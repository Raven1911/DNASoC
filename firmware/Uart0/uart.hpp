#ifndef UART_H
#define UART_H

#include <stdint.h>

// Địa chỉ cơ sở của UART
#define UART_BASE_ADDR 0x02002000
#define UART_DVSR_REG   (UART_BASE_ADDR + 0x00000001)  // WRITE    //Thanh ghi baud rate
#define UART_TX_REG     (UART_BASE_ADDR + 0x00000002)  // WRITE    //Thanh ghi truyền
#define UART_RX_REG     (UART_BASE_ADDR + 0x00000003)  // READ     //Thanh ghi nhận và trạng thái


// Định nghĩa bit trạng thái
#define UART_TX_FULL    (1 << 9)  // Bit 9: TX Full
#define UART_RX_EMPTY   (1 << 8)  // Bit 8: RX Empty
#define UART_DATA_MASK  0xFF      // Bit [7:0]: Dữ liệu

class Uart {
private:
    /* data */
    volatile uint32_t* base_addr; // Con trỏ đến địa chỉ cơ sở UART

    // Ghi dữ liệu 32-bit vào thanh ghi
    void write_reg(uint32_t offset, uint32_t value);

    // Đọc dữ liệu 32-bit từ thanh ghi
    uint32_t read_reg(uint32_t offset);

public:
    // Constructor
    Uart(uint32_t base = UART_BASE_ADDR);
    //~Uart();

    // Cấu hình UART với baud rate
    void init(uint32_t clk_freq, uint32_t baud_rate);

    // Gửi một byte
    void write(uint8_t data);

    // Đọc một byte, trả về -1 nếu không có dữ liệu
    int16_t read();

    // Kiểm tra xem TX có đầy không
    bool is_tx_full();

    // Kiểm tra xem RX có rỗng không
    bool is_rx_empty();

    // Gửi một chuỗi ký tự
    void write_string(const char* str);
};






#endif