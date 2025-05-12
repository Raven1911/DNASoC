#include <WiFi.h>
#include <HTTPClient.h>
#include <HardwareSerial.h>
#include <ArduinoJson.h>

#define CMD_INIT_UART1 0x10
#define CMD_CHECK_REF_UART1 0x2A
#define CMD_CHECK_READ_UART1 0x2B
#define CMD_READ_READ_UART1 0x2C
#define CMD_READ_REF_UART1 0x2D
#define CMD_SEND_MATRIX_UART1 0x2E

// Định nghĩa chân UART cho UART1 (nhận lệnh và gửi dữ liệu từ/to Hercules)
static const uint8_t UART1_TX = 27; // P2 // 27
static const uint8_t UART1_RX = 19; // P14

// Khởi tạo UART1 để nhận lệnh và gửi dữ liệu
HardwareSerial SerialPort1(1);      // UART1
const char *ssid = "test";         // Tên WiFi
const char *password = "123456798"; // Mật khẩu WiFi

const char *serverName = "192.168.45.11"; // Cập nhật IP đúng của server
const int serverPort = 80;
bool mode = false;     // false: receive, true: send
bool isSynced = false; // Trạng thái đồng bộ

// Buffer để lưu trữ DNA Read và DNA Reference dưới dạng mảng byte
uint8_t dnaReadArray[100]; // Kích thước tối đa 100 byte
uint8_t dnaRefArray[100];  // Kích thước tối đa 100 byte
uint32_t dnaReadLength = 0;
uint32_t dnaRefLength = 0;

// Chuỗi nhị phân toàn cục để lưu dữ liệu từ web
String dnaReadBinary = "";
String dnaRefBinary = "";

// Chỉ số hiện tại để gửi DNA Read và DNA Reference
uint32_t readIndex = 0;
uint32_t refIndex = 0;

// Buffer để nhận dữ liệu ma trận
uint8_t matrixBuffer[72]; // 576 bit = 72 byte
uint32_t matrixBufferIndex = 0;

// Chuyển chuỗi nhị phân thành mảng byte, hiển thị chi tiết
void stringToByteArray(const String &binary, uint8_t *array, uint32_t &length)
{
  length = 0;
  Serial.println("Converting binary string to byte array:");
  Serial.println("Input binary: " + binary);
  for (int i = 0; i < binary.length(); i += 8)
  {
    uint8_t byte = 0;
    String byteBinary = "";
    for (int j = 0; j < 8 && (i + j) < binary.length(); j++)
    {
      byteBinary += binary[i + j];
      if (binary[i + j] == '1')
      {
        byte |= (1 << (7 - j));
      }
    }
    while (byteBinary.length() < 8)
    {
      byteBinary += "0"; // Padding với 0 nếu chuỗi ngắn hơn 8 bit
    }
    array[length] = byte;
    Serial.print("Byte " + String(length) + ": " + byteBinary + " (Decimal: " + String(byte) + ", Hex: 0x" + String(byte, HEX) + ")");
    Serial.println();
    length++;
  }
  // Đảm bảo length là bội số của 4 bằng cách thêm padding nếu cần
  while (length % 4 != 0)
  {
    array[length] = 0; // Thêm byte 0
    length++;
    Serial.println("Added padding byte: 00000000 (Decimal: 0, Hex: 0x0)");
  }
  Serial.println("Total length: " + String(length) + " bytes");
}

// Khai báo hàm trước khi sử dụng
void syncWithWeb();

void setup()
{
  // Khởi tạo UART0 cho Serial Monitor (debug)
  Serial.begin(115200);

  // Khởi tạo UART1 để nhận lệnh và gửi dữ liệu
  SerialPort1.begin(9600, SERIAL_8N1, UART1_RX, UART1_TX);

  // Connect to WiFi
  Serial.println("Connecting to WiFi...");
  WiFi.begin(ssid, password);

  while (WiFi.status() != WL_CONNECTED)
  {
    delay(500);
    Serial.print(".");
  }
  Serial.println("\nWiFi Connected!");
  Serial.print("IP Address: ");
  Serial.println(WiFi.localIP());

  // Kiểm tra kết nối tới server
  IPAddress ip;
  if (WiFi.hostByName(serverName, ip))
  {
    Serial.println("Server reachable!");
  }
  else
  {
    Serial.println("Server not reachable! Kiểm tra IP hoặc mạng.");
  }

  // Đồng bộ dữ liệu với web (chỉ kiểm tra kết nối, không nhận dữ liệu ngay)
  syncWithWeb();

  Serial.println("Enter 'r' to receive data and send via UART, 's' to send data, 't' to test UART1:");
  Serial.println("Gửi lệnh 'INIT' qua UART1 để nhận dữ liệu từ web.");
}

void syncWithWeb()
{
  Serial.println("Đang đồng bộ với web...");
  int maxRetries = 20;   // Retry tối đa 20 lần
  int retryDelay = 5000; // 5 giây mỗi lần retry

  while (!isSynced && maxRetries > 0)
  {
    if (WiFi.status() == WL_CONNECTED)
    {
      HTTPClient http;
      String serverPath = "http://" + String(serverName) + ":" + String(serverPort) + "/api/check_data";

      http.begin(serverPath);
      http.setTimeout(10000);

      int httpResponseCode = http.GET();

      if (httpResponseCode > 0)
      {
        String payload = http.getString();
        Serial.println("Kết quả kiểm tra dữ liệu:");
        Serial.println(payload);

        if (payload.indexOf("\"status\": \"ready\"") != -1)
        {
          Serial.println("Dữ liệu đã sẵn sàng!");
          isSynced = true; // Đánh dấu đã đồng bộ
        }
        else
        {
          Serial.println("Dữ liệu chưa sẵn sàng. Đang chờ upload từ web...");
          delay(retryDelay);
          maxRetries--;
        }
      }
      else
      {
        Serial.print("Lỗi kiểm tra dữ liệu. HTTP Code: ");
        Serial.println(httpResponseCode);
        Serial.println("Thử lại... Số lần còn lại: " + String(maxRetries));
        delay(retryDelay);
        maxRetries--;
      }
      http.end();
    }
    else
    {
      Serial.println("WiFi Disconnected. Reconnecting...");
      WiFi.reconnect();
      delay(2000);
    }
  }

  if (!isSynced)
  {
    Serial.println("Không thể đồng bộ với web sau nhiều lần thử. Kiểm tra server và dữ liệu trên web!");
    while (true)
      ; // Dừng chương trình nếu không đồng bộ được
  }
}

void receiveData()
{
  if (!isSynced)
  {
    Serial.println("Chưa đồng bộ với web. Vui lòng khởi động lại!");
    return;
  }

  if (WiFi.status() == WL_CONNECTED)
  {
    HTTPClient http;
    String serverPath = "http://" + String(serverName) + ":" + String(serverPort) + "/api/get_encoded";

    http.begin(serverPath);
    http.setTimeout(10000);

    int httpResponseCode = http.GET();

    if (httpResponseCode > 0)
    {
      String payload = http.getString();
      Serial.println("Dữ liệu nhận được từ web:");
      Serial.println(payload);

      // Loại bỏ các ký tự xuống dòng và khoảng trắng thừa
      payload.replace("\n", ""); // Xóa ký tự xuống dòng
      payload.replace("\r", ""); // Xóa ký tự carriage return (nếu có)
      while (payload.indexOf("  ") != -1)
      {
        payload.replace("  ", " "); // Thay thế nhiều khoảng trắng bằng một khoảng trắng
      }
      payload.trim(); // Xóa khoảng trắng ở đầu và cuối
      Serial.println("Payload sau khi làm sạch:");
      Serial.println(payload);

      // Sử dụng JsonDocument với deserializeJson
      DynamicJsonDocument doc(1024); // Kích thước bộ nhớ cho JsonDocument

      // Phân tích JSON
      DeserializationError error = deserializeJson(doc, payload);
      if (error)
      {
        Serial.print("deserializeJson() failed: ");
        Serial.println(error.c_str());
        return;
      }

      // Trích xuất dữ liệu mã hóa
      const char *dnaRead = doc["DNA Read"];
      const char *dnaRef = doc["DNA Reference"];

      if (dnaRead)
      {
        Serial.println("Đã tìm thấy DNA Read trong JSON!");
        dnaReadBinary = String(dnaRead);
        Serial.println("Extracted DNA Read: " + dnaReadBinary);
        stringToByteArray(dnaReadBinary, dnaReadArray, dnaReadLength);
        Serial.println("Final DNA Read Length: " + String(dnaReadLength));
      }
      else
      {
        Serial.println("Không thể trích xuất DNA Read từ JSON!");
      }

      if (dnaRef)
      {
        Serial.println("Đã tìm thấy DNA Reference trong JSON!");
        dnaRefBinary = String(dnaRef);
        Serial.println("Extracted DNA Reference: " + dnaRefBinary);
        stringToByteArray(dnaRefBinary, dnaRefArray, dnaRefLength);
        Serial.println("Final DNA Reference Length: " + String(dnaRefLength));
      }
      else
      {
        Serial.println("Không thể trích xuất DNA Reference từ JSON!");
      }
    }
    else
    {
      Serial.print("Error receiving data. HTTP Code: ");
      Serial.println(httpResponseCode);
    }
    http.end();
  }
  else
  {
    Serial.println("WiFi Disconnected");
  }
}
void sendData()
{
  if (!isSynced)
  {
    Serial.println("Chưa đồng bộ với web. Vui lòng khởi động lại!");
    return;
  }

  String bits = "";
  Serial.println("Chuyển sang chế độ gửi dữ liệu...");
  Serial.println("Nhập chuỗi bit (ví dụ: 001001001011010):");
  while (bits == "")
  {
    if (Serial.available())
    {
      bits = Serial.readStringUntil('\n');
      bits.trim();
    }
  }

  if (WiFi.status() == WL_CONNECTED)
  {
    HTTPClient http;
    String serverPath = "http://" + String(serverName) + ":" + String(serverPort) + "/matrix";

    http.begin(serverPath);
    http.setTimeout(10000);
    http.addHeader("Content-Type", "application/x-www-form-urlencoded");

    String postData = "action=update&bits=" + bits;
    Serial.print("Gửi yêu cầu tới ");
    Serial.println(serverPath);
    int httpResponseCode = http.POST(postData);

    if (httpResponseCode > 0)
    {
      String payload = http.getString();
      Serial.println("Gửi yêu cầu thành công!");
      Serial.println("Response: " + payload);
    }
    else
    {
      Serial.print("Error sending request. HTTP Code: ");
      Serial.println(httpResponseCode);
    }
    http.end();
  }
  else
  {
    Serial.println("WiFi Disconnected");
  }
}

void testUART1()
{
  Serial.println("Testing UART1 by sending a test message...");
  String testMessage = "10101010";
  for (char bit : testMessage)
  {
    uint8_t value = (bit == '1') ? 1 : 0;
    SerialPort1.write(value);
    delay(50);
  }
  SerialPort1.write(0xFF);
  Serial.println("Test message sent via UART1: " + testMessage);
}

// Gửi 32-bit qua UART1 (4 lần, mỗi lần 8 bit)
void sendUint32(uint32_t value)
{
  // Send LSB first for little-endian
  for (int i = 0; i < 4; i++) // i = 0, 1, 2, 3
  {
    // i=0: (value >> 0) & 0xFF  (LSB)
    // i=1: (value >> 8) & 0xFF
    // i=2: (value >> 16) & 0xFF
    // i=3: (value >> 24) & 0xFF (MSB)
    uint8_t byte = (value >> (i * 8)) & 0xFF;
    SerialPort1.write(byte);
    Serial.print("Sent byte (sendUint32): 0x");
    if (byte < 0x10)
      Serial.print("0");
    Serial.println(byte, HEX);
    delay(50);
  }
}

// Gửi 32 bit của mảng byte qua UART1
void send32BitsFromArray(const uint8_t *array, uint32_t &index, uint32_t length)
{
  if (index >= length)
  {
    Serial.println("Đã gửi hết mảng!");
    return;
  }

  // stringToByteArray ensures length is a multiple of 4, and index is advanced by 4.
  // So, if index < length, then (index + 3) < length should hold.

  // To send in little-endian: send array[index+3], then array[index+2], ..., array[index+0]

  if ((index + 3) < length)
  { // Check to be safe, though padding should ensure this
    uint8_t byte_to_send;

    // Send LSB of this 4-byte segment first
    byte_to_send = array[index + 3];
    SerialPort1.write(byte_to_send);
    Serial.print("Sent byte (arr[" + String(index + 3) + "]): 0x");
    if (byte_to_send < 0x10)
      Serial.print("0");
    Serial.println(byte_to_send, HEX);
    delay(50);

    byte_to_send = array[index + 2];
    SerialPort1.write(byte_to_send);
    Serial.print("Sent byte (arr[" + String(index + 2) + "]): 0x");
    if (byte_to_send < 0x10)
      Serial.print("0");
    Serial.println(byte_to_send, HEX);
    delay(50);

    byte_to_send = array[index + 1];
    SerialPort1.write(byte_to_send);
    Serial.print("Sent byte (arr[" + String(index + 1) + "]): 0x");
    if (byte_to_send < 0x10)
      Serial.print("0");
    Serial.println(byte_to_send, HEX);
    delay(50);

    // Send MSB of this 4-byte segment last
    byte_to_send = array[index + 0];
    SerialPort1.write(byte_to_send);
    Serial.print("Sent byte (arr[" + String(index + 0) + "]): 0x");
    if (byte_to_send < 0x10)
      Serial.print("0");
    Serial.println(byte_to_send, HEX);
    delay(50);
  }
  else
  {
    // This should ideally not be reached if padding works as expected
    Serial.println("Error: Not enough bytes in array for a full 32-bit word at index " + String(index));
  }

  index += 4;
}

void loop()
{
  // Nhận dữ liệu từ UART1 (lệnh từ Hercules)
  if (SerialPort1.available())
  {
    uint8_t command = SerialPort1.read();
    Serial.print("Received UART1 command byte: 0x");
    if (command < 0x10)
    {
      Serial.print("0"); // Add leading zero for single-digit hex values
    }
    Serial.println(command, HEX);

    switch (command)
    {
    case CMD_INIT_UART1:
    {
      Serial.println("Received INIT command");
      readIndex = 0; // Reset chỉ số khi nhận dữ liệu mới
      refIndex = 0;
      receiveData();
      break;
    }
    case CMD_CHECK_READ_UART1:
    {
      readIndex = 0; // Reset chỉ số khi nhận dữ liệu mới
      refIndex = 0;
      receiveData();
      Serial.println("Received Checkread command");
      Serial.println("Debug DNA Read Length: " + (String)(dnaReadLength / 4));
      sendUint32(dnaReadLength / 4);
      break;
    }
    case CMD_CHECK_REF_UART1:
    {
      Serial.println("Received Checkref command");
      sendUint32(dnaRefLength / 4);
      break;
    }
    case CMD_READ_READ_UART1:
    {
      Serial.println("Received Readread command");
      send32BitsFromArray(dnaReadArray, readIndex, dnaReadLength);
      break;
    }
    case CMD_READ_REF_UART1:
    {
      Serial.println("Received Readref command");
      send32BitsFromArray(dnaRefArray, refIndex, dnaRefLength);
      break;
    }
    case CMD_SEND_MATRIX_UART1:
    {
      Serial.println("Received SendMatrixvalues command");
      matrixBufferIndex = 0; // Reset buffer index
      Serial.println("Waiting for 72 matrix bytes...");

      uint32_t startTime = millis();
      const uint32_t matrixReadTimeout = 5000; // 5-second timeout to receive all 72 bytes

      while (matrixBufferIndex < 72)
      {
        if (SerialPort1.available())
        {
          matrixBuffer[matrixBufferIndex] = SerialPort1.read();
          Serial.println("Received matrix byte: " + String(matrixBuffer[matrixBufferIndex], HEX)); // Optional: for detailed debugging
          matrixBufferIndex++;
          startTime = millis(); // Reset timeout on each byte received
        }
        if (millis() - startTime > matrixReadTimeout)
        {
          Serial.println("Timeout waiting for matrix data!");
          break;
        }
        yield(); // Allow other ESP32 tasks to run
      }

      if (matrixBufferIndex == 72)
      {
        Serial.println("Successfully received 72 matrix bytes.");
        Serial.println("Matrix received (72 bytes):");
        for (int i = 0; i < 72; i++)
        {
          Serial.print("0x");
          if (matrixBuffer[i] < 0x10)
            Serial.print("0");
          Serial.print(matrixBuffer[i], HEX);
          Serial.print(" ");
          if ((i + 1) % 16 == 0)
            Serial.println();
        }
        Serial.println();

        // Convert matrix to bit string, accounting for little-endian to big-endian conversion
        String bits = "";
        for (uint32_t i = 0; i < 72; i += 4)
        {
          // Reorder bytes to interpret as big-endian
          // matrixBuffer[i:i+3] is a 32-bit word in little-endian: [b3, b2, b1, b0] (b3 is LSB)
          // We want big-endian: [b0, b1, b2, b3] (b0 is MSB)
          uint8_t reordered[4] = {
              matrixBuffer[i + 3], // b0 (MSB)
              matrixBuffer[i + 2], // b1
              matrixBuffer[i + 1], // b2
              matrixBuffer[i + 0]  // b3 (LSB)
          };

          // Convert reordered bytes to bits (MSB first)
          for (int byteIdx = 0; byteIdx < 4; byteIdx++)
          {
            for (int bit = 7; bit >= 0; bit--)
            {
              bits += (reordered[byteIdx] & (1 << bit)) ? "1" : "0";
            }
          }
        }

        Serial.println("Converted Matrix BitString (576 bits, big-endian order):");
        Serial.println(bits);

        // Send to web
        if (WiFi.status() == WL_CONNECTED)
        {
          HTTPClient http;
          String serverPath = "http://" + String(serverName) + ":" + String(serverPort) + "/matrix";

          http.begin(serverPath);
          http.setTimeout(10000); // milliseconds
          http.addHeader("Content-Type", "application/x-www-form-urlencoded");

          String postData = "action=update&bits=" + bits;
          Serial.print("Sending request to ");
          Serial.println(serverPath);
          int httpResponseCode = http.POST(postData);

          if (httpResponseCode > 0)
          {
            String payload = http.getString();
            Serial.println("Matrix sent successfully!");
            Serial.println("Response: " + payload);
          }
          else
          {
            Serial.print("Error sending matrix. HTTP Code: ");
            Serial.println(httpResponseCode);
          }
          http.end();
        }
        else
        {
          Serial.println("WiFi Disconnected, cannot send matrix.");
        }
      }
      else
      {
        Serial.println("Failed to receive all 72 matrix bytes. Received only " + String(matrixBufferIndex) + " bytes.");
      }
      break;
    }
    default:
      Serial.println("Unknown UART1 command: " + String(command, HEX));
      break;
    }
  }

  // Xử lý lệnh từ Serial Monitor
  if (Serial.available())
  {
    char command = Serial.read();
    if (command == 'r')
    {
      Serial.println("Received 'r' command from Serial Monitor");
      readIndex = 0; // Reset chỉ số khi nhận dữ liệu mới
      refIndex = 0;
      receiveData();
    }
    else if (command == 's')
    {
      mode = true;
      Serial.println("Switching to send mode...");
      sendData();
    }
    else if (command == 't')
    {
      testUART1();
    }
  }
  delay(100);
}