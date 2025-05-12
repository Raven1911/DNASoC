#include <string>
#include "uart.hpp"
#include <stdint.h>

// --- UART Communication Command Definitions ---
// These commands are sent to/from a host (e.g., Laptop) to coordinate data transfer.
#define CMD_CHECK_REF_SIZE 0x2A  // Command to request the size of the reference DNA sequence
#define CMD_CHECK_READ_SIZE 0x2B // Command to request the size of the read DNA sequence
#define CMD_READ_READ_DATA 0x2C  // Command to request a word of the read DNA sequence data
#define CMD_READ_REF_DATA 0x2D   // Command to request a word of the reference DNA sequence data
#define CMD_WRITE_MATRIX 0x2E    // Command to indicate the start of sending the output matrix data

// --- General Purpose Definitions ---
#define BYTE_MASK 0xFF                 // Mask to extract a single byte from a word
#define BYTE_SHIFT 8                   // Number of bits to shift to access the next byte in a word
#define NUM_OUTPUT_REGISTERS 16        // Number of output matrix registers in the DNA processing IP
#define OUTPUT_REGISTER_SIZE_WORDS 128 // Size of each output matrix register in 32-bit words

// --- DNA Sequence Alignment Scoring Parameters ---
// These values are used to configure the DNA processing IP's scoring mechanism.
#define SCORE_MATCH 0x2    // Score for a matching pair of characters (0-7)
#define SCORE_MISMATCH 0x1 // Penalty for a mismatching pair of characters (0-7)
#define SCORE_GAP 0x2      // Penalty for a gap in the alignment (0-7)

// --- DNA Processing IP Register Definitions ---
#define DNA_IP_BASE_ADDR 0x02004000  // Base address for the DNA processing IP's control registers
#define DNA_IP_START_REG_OFFSET 0x00 // Word offset for the Start Register (controls IP execution)
// Bit definitions within the DNA IP Configuration Register
// Field is contiguous from LSB:
// [0] : Start bit (1 to start, 0 to stop)
// [1] : Reset bit (1 to reset, 0 to release reset)
#define DNA_IP_START_REG_START_BIT 0                                   // Start bit for the Start Register
#define DNA_IP_START_REG_START_MASK (1U << DNA_IP_START_REG_START_BIT) // Mask for the Start bit
#define DNA_IP_START_REG_RST_BIT 1                                     // Reset bit for the Start Register
#define DNA_IP_START_REG_RST_MASK (1U << DNA_IP_START_REG_RST_BIT)     // Mask for the Reset bit

#define DNA_IP_CONFIG_REG_OFFSET 0x01 // Word offset for the Configuration Register

// Bit definitions within the DNA IP Configuration Register
// Address: DNA_IP_BASE_ADDR + (DNA_IP_CONFIG_REG_OFFSET * 4)
// Fields are contiguous from LSB:
// [6:0]   : Read Data Width (length of the 'read' sequence)
// [9:7]   : Match Score
// [12:10]  : Mismatch Score
// [15:13] : Gap Score

#define DNA_CFG_READ_WIDTH_START_BIT 0 // Start bit for Read Data Width field
#define DNA_CFG_READ_WIDTH_BITS 7      // Number of bits for Read Data Width field
#define DNA_CFG_READ_WIDTH_MASK (((1U << DNA_CFG_READ_WIDTH_BITS) - 1) << DNA_CFG_READ_WIDTH_START_BIT)

#define DNA_CFG_MATCH_SCORE_START_BIT 7 // Start bit for Match Score field
#define DNA_CFG_MATCH_SCORE_BITS 3      // Number of bits for Match Score field
#define DNA_CFG_MATCH_SCORE_MASK (((1U << DNA_CFG_MATCH_SCORE_BITS) - 1) << DNA_CFG_MATCH_SCORE_START_BIT)

#define DNA_CFG_MISMATCH_SCORE_START_BIT 10 // Start bit for Mismatch Score field
#define DNA_CFG_MISMATCH_SCORE_BITS 3       // Number of bits for Mismatch Score field
#define DNA_CFG_MISMATCH_SCORE_MASK (((1U << DNA_CFG_MISMATCH_SCORE_BITS) - 1) << DNA_CFG_MISMATCH_SCORE_START_BIT)

#define DNA_CFG_GAP_SCORE_START_BIT 13 // Start bit for Gap Score field
#define DNA_CFG_GAP_SCORE_BITS 3       // Number of bits for Gap Score field
#define DNA_CFG_GAP_SCORE_MASK (((1U << DNA_CFG_GAP_SCORE_BITS) - 1) << DNA_CFG_GAP_SCORE_START_BIT)

#define DNA_IP_STATUS_REG_OFFSET 0x02 // Word offset for the Status Register (indicates IP completion/status)
// Bit definitions within the DNA IP Configuration Register
#define DNA_IP_STATUS_REG_DONE_BIT 0                                                 // Bit indicating if the IP has completed processing
#define DNA_IP_STATUS_REG_DONE_MASK (1U << DNA_IP_STATUS_REG_DONE_BIT)               // Mask for the Done bit
#define DNA_IP_STATUS_REG_REF_EMPTY_BIT 1                                            // Bit indicating if the reference data has been processed
#define DNA_IP_STATUS_REG_REF_EMPTY_MASK (1U << DNA_IP_STATUS_REG_REF_EMPTY_BIT)     // Mask for the Reference Done bit
#define DNA_IP_STATUS_REG_MATRIX_DONE_BIT 2                                          // Bit indicating if the output matrix has been processed
#define DNA_IP_STATUS_REG_MATRIX_DONE_MASK (1U << DNA_IP_STATUS_REG_MATRIX_DONE_BIT) // Mask for the Matrix Done bit

// --- End of DNA IP Register Definitions ---

// --- DNA Data Memory Access Definitions ---
#define DNA_DATA_MEMORY_BASE_ADDR 0x03000000                  // Base address for the memory used by the DNA processing IP
#define MEM_SEGMENT_READ_DATA_OFFSET 0x0000                   // Word offset for the 'read' DNA sequence data segment (write-only by CPU)
#define MEM_SEGMENT_REF_DATA_OFFSET 0x0400                    // Word offset for the 'reference' DNA sequence data segment (write-only by CPU)
                                                              // Calculation: (0x03001000 - 0x03000000) / 4
#define MEM_SEGMENT_MATRIX_BASE_OFFSET 0x4000                 // Word offset for the base of the output matrix data segment (read-only by CPU)
                                                              // Calculation: (0x03010000 - 0x03000000) / 4
#define MATRIX_REGISTER_SIZE_WORDS OUTPUT_REGISTER_SIZE_WORDS // Each matrix 'register' has 128 words (Redundant, OUTPUT_REGISTER_SIZE_WORDS is descriptive)
#define MATRIX_REG_WORD_STRIDE 0x4000                         // Word stride between consecutive matrix registers in memory (if applicable, often matrix data is contiguous or IP handles internal addressing)
// --- End of DNA Data Memory Access Definitions ---

void init_trans_receiv(Uart &);
uint32_t DNA_init(Uart &, uint8_t, uint8_t, uint8_t);
uint32_t read_axi_reg(uint32_t, uint32_t);
void write_axi_reg(uint32_t, uint32_t, uint32_t);

uint32_t checkread(Uart &);
uint32_t checkref(Uart &);
uint32_t readread(Uart &);
uint32_t readref(Uart &);

uint32_t receive_and_store_ref_data(Uart &);
uint32_t receive_and_store_read_data(Uart &);
void receive_and_send_output_matrix(Uart &, uint32_t, uint32_t *, uint32_t *);

void send_word(Uart &, uint32_t);
void send_output_reg(Uart &, uint32_t);

// Memory function declarations
uint32_t mem_read_word(uint32_t, uint32_t);
uint32_t mem_read_bits(uint32_t, uint32_t, uint8_t, uint8_t);
void mem_write_word(uint32_t, uint32_t, uint32_t);
void mem_write_bits(uint32_t, uint32_t, uint32_t, uint8_t, uint8_t);

int main()
{
    Uart uart_dna;
    uint32_t idx_matrix_i = 0, idx_matrix_j = 0;

    init_trans_receiv(uart_dna);
    uint32_t read_width_for_config = DNA_init(uart_dna, SCORE_MATCH, SCORE_MISMATCH, SCORE_GAP);
    // --- Data Generation and IP Configuration ---
    // const uint32_t read_data_num_words = 2; // 32 bits for read data
    // const uint32_t ref_data_num_words = 2;  // 32 bits for reference data

    // uint32_t read_data[read_data_num_words]; // 12 nucleotides (4 bytes) of read data
    // uint32_t ref_data[ref_data_num_words];   // 12 nucleotides (4 bytes) of reference data

    // read_data[0] = 0b00001110010011111111111001111111; // 12 nucleotides (4 bytes) of read data
    // mem_write_word(MEM_SEGMENT_READ_DATA_OFFSET, 0, read_data[0]);
    // read_data[1] = 0b00001100000011111111111001111111; // 12 nucleotides (4 bytes) of read data
    // mem_write_word(MEM_SEGMENT_READ_DATA_OFFSET, 1, read_data[1]);

    // ref_data[0] = 0b00001110011111111111100111111111;
    // mem_write_word(MEM_SEGMENT_REF_DATA_OFFSET, 0, ref_data[0]);
    // ref_data[1] = 0b00001110011111111111100111111111;
    // mem_write_word(MEM_SEGMENT_REF_DATA_OFFSET, 1, ref_data[1]);

    // mem_write_word(MEM_SEGMENT_REF_DATA_OFFSET, ref_data_num_words, 0x0); // Add a 0 to the end to avoid pipeline stall

    // // Configure the DNA IP
    // uint32_t read_width_for_config = read_data_num_words; // Read width is the number of words in the read sequence
    // if (read_width_for_config == 0 || read_width_for_config == 1)
    // {
    //     read_width_for_config = 0;
    // }
    // else
    // {
    //     uint32_t count = 0;
    //     while (read_width_for_config > 1)
    //     {
    //         read_width_for_config >>= 1;
    //         count++;
    //     }
    //     read_width_for_config = count;
    // }
    // uint32_t config_value = 0;

    // config_value |= (read_width_for_config << DNA_CFG_READ_WIDTH_START_BIT) & DNA_CFG_READ_WIDTH_MASK;
    // config_value |= (SCORE_MATCH << DNA_CFG_MATCH_SCORE_START_BIT) & DNA_CFG_MATCH_SCORE_MASK;
    // config_value |= (SCORE_MISMATCH << DNA_CFG_MISMATCH_SCORE_START_BIT) & DNA_CFG_MISMATCH_SCORE_MASK;
    // config_value |= (SCORE_GAP << DNA_CFG_GAP_SCORE_START_BIT) & DNA_CFG_GAP_SCORE_MASK;

    // write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_CONFIG_REG_OFFSET, config_value);                                                     // Config the IP
    // write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, (0x0 << DNA_IP_START_REG_START_BIT) & DNA_IP_START_REG_START_MASK); // Ensure IP is stopped initially
    // write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, (0x1 << DNA_IP_START_REG_RST_BIT) & DNA_IP_START_REG_RST_MASK);     // Reset the IP
    // write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, (0x0 << DNA_IP_START_REG_RST_BIT) & DNA_IP_START_REG_RST_MASK);     // Release reset
    // read_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_STATUS_REG_OFFSET);
    // uart_dna.write((uint8_t)0x10);

    // --- End of Data Generation and IP Configuration ---
    uint32_t status_reg = 0;
    uint32_t matrix_full = 0, ref_empty = 0;

    write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, 0x1 & DNA_IP_START_REG_START_MASK);
    write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, 0x0 & DNA_IP_START_REG_START_MASK);
    status_reg = read_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_STATUS_REG_OFFSET);
    ref_empty = (status_reg & DNA_IP_STATUS_REG_REF_EMPTY_MASK) >> DNA_IP_STATUS_REG_REF_EMPTY_BIT;

    if (ref_empty == 0x1)
    {
        // Testing purpose: Send the reference data to the memory
        // for (uint32_t i = 0; i < ref_data_num_words; ++i)
        // {
        //     mem_write_word(MEM_SEGMENT_REF_DATA_OFFSET, i, ref_data[i]);
        // }

        // receive_and_store_ref_data(uart_dna); // Received and store data into DNA-mem
    }

    matrix_full = (status_reg & DNA_IP_STATUS_REG_MATRIX_DONE_MASK) >> DNA_IP_STATUS_REG_MATRIX_DONE_BIT;

    if (matrix_full == 0x1)
    {
        // Testing purpose: Send the output matrix to the memory
        // status_reg = mem_read_word(MEM_SEGMENT_MATRIX_BASE_OFFSET, 0); // Read the output matrix from DNA-mem
        // send_word(uart_dna, status_reg);

        receive_and_send_output_matrix(uart_dna, read_width_for_config, &idx_matrix_i, &idx_matrix_j); // Send the output matrix to the host
        // write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, 0x1 & DNA_IP_START_REG_START_MASK); // Start the IP again
    }
    // while (1)
    // {}
    return 0;
}

void init_trans_receiv(Uart &uart)
{
    uart.init(75000000, 9600);
}

uint32_t DNA_init(Uart &uart, uint8_t match_score, uint8_t mismatch_score, uint8_t gap_score)
{
    for (volatile int delay = 0; delay < 0xFFFF; ++delay)
        ;
    uart.write((uint8_t)0x10);
    write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, (0x0 << DNA_IP_START_REG_START_BIT) & DNA_IP_START_REG_START_MASK); // stop the ip
    // prepair the data
    uint32_t read_width = receive_and_store_read_data(uart);
    uint32_t ref_width = receive_and_store_ref_data(uart);
    uint32_t config_value = 0;

    uint32_t read_width_for_config = read_width; // Read width is the number of words in the read sequence
    if (read_width_for_config == 0 || read_width_for_config == 1)
    {
        read_width_for_config = 0;
    }
    else
    {
        uint32_t count = 0;
        while (read_width_for_config > 1)
        {
            read_width_for_config >>= 1;
            count++;
        }
        read_width_for_config = count;
    }

    config_value |= (read_width_for_config << DNA_CFG_READ_WIDTH_START_BIT) & DNA_CFG_READ_WIDTH_MASK;
    config_value |= (match_score << DNA_CFG_MATCH_SCORE_START_BIT) & DNA_CFG_MATCH_SCORE_MASK;
    config_value |= (mismatch_score << DNA_CFG_MISMATCH_SCORE_START_BIT) & DNA_CFG_MISMATCH_SCORE_MASK;
    config_value |= (gap_score << DNA_CFG_GAP_SCORE_START_BIT) & DNA_CFG_GAP_SCORE_MASK;

    write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_CONFIG_REG_OFFSET, config_value); // config the ip
    mem_write_word(MEM_SEGMENT_REF_DATA_OFFSET, ref_width, 0x0);             // add a 0 to the end to avoid pipeline stall

    write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, (0x1 << DNA_IP_START_REG_RST_BIT) & DNA_IP_START_REG_RST_MASK); // Reset the IP
    write_axi_reg(DNA_IP_BASE_ADDR, DNA_IP_START_REG_OFFSET, (0x0 << DNA_IP_START_REG_RST_BIT) & DNA_IP_START_REG_RST_MASK); // Release reset
    return read_width_for_config;
}

uint32_t read_axi_reg(uint32_t base_addr, uint32_t offset)
{
    volatile uint32_t *periph_base = (volatile uint32_t *)base_addr;
    return (*(periph_base + offset));
}
void write_axi_reg(uint32_t base_addr, uint32_t offset, uint32_t data_to_write)
{
    volatile uint32_t *periph_base = (volatile uint32_t *)base_addr;
    *(periph_base + offset) = data_to_write;
}

void send_word(Uart &uart, uint32_t word)
{
    for (volatile int delay = 0; delay < 0xFFFF; ++delay)
        ;
    uart.write((word >> (BYTE_SHIFT * 3)) & BYTE_MASK); // MSB
    uart.write((word >> (BYTE_SHIFT * 2)) & BYTE_MASK);
    uart.write((word >> (BYTE_SHIFT * 1)) & BYTE_MASK);
    uart.write((word >> (BYTE_SHIFT * 0)) & BYTE_MASK); // LSB
}

uint32_t checkread(Uart &uart)
{
    for (volatile int delay = 0; delay < 10000; ++delay)
        ; // Delay to allow UART to process previous data
    uart.write(CMD_CHECK_READ_SIZE);
    uint32_t tmp = 0;
    for (int i = 0; i < 4; i++)
    {
        int16_t byte;
        do
        {
            byte = uart.read();
        } while (byte == -1);
        tmp |= ((byte & BYTE_MASK) << (BYTE_SHIFT * i));
    }
    return tmp;
}

uint32_t checkref(Uart &uart)
{
    for (volatile int delay = 0; delay < 10000; ++delay)
        ; // Delay to allow UART to process previous data
    uart.write(CMD_CHECK_REF_SIZE);
    uint32_t tmp = 0;
    for (int i = 0; i < 4; i++)
    {
        int16_t byte;
        do
        {
            byte = uart.read();
        } while (byte == -1);
        tmp |= ((byte & BYTE_MASK) << (BYTE_SHIFT * i));
    }
    return tmp;
}

uint32_t readread(Uart &uart)
{
    for (volatile int delay = 0; delay < 10000; ++delay)
        ; // Delay to allow UART to process previous data
    uart.write(CMD_READ_READ_DATA);
    uint32_t tmp = 0;
    for (int i = 0; i < 4; i++)
    {
        int16_t byte;
        do
        {
            byte = uart.read();
        } while (byte == -1);
        tmp |= ((byte & BYTE_MASK) << (BYTE_SHIFT * i));
    }
    return tmp;
}

uint32_t readref(Uart &uart)
{
    for (volatile int delay = 0; delay < 10000; ++delay)
        ; // Delay to allow UART to process previous data
    uart.write(CMD_READ_REF_DATA);
    uint32_t tmp = 0;
    for (int i = 0; i < 4; i++)
    {
        int16_t byte;
        do
        {
            byte = uart.read();
        } while (byte == -1);
        tmp |= ((byte & BYTE_MASK) << (BYTE_SHIFT * i));
    }
    return tmp;
}

uint32_t receive_and_store_ref_data(Uart &uart)
{
    uint32_t idx_ref = 0;
    uint32_t num = checkref(uart);
    if (num == 0x0 || num == 0xFFFFFFFF)
    {
        return 0;
    }
    for (int i = 0; i < num; i++)
    {
        uint32_t data_word = readref(uart);
        mem_write_word(MEM_SEGMENT_REF_DATA_OFFSET, idx_ref, data_word);
        idx_ref++;
    }
    return num;
}

uint32_t receive_and_store_read_data(Uart &uart)
{
    uint32_t idx_read = 0;
    uint32_t num = checkread(uart);
    if (num == 0x0 || num == 0xFFFFFFFF)
    {
        return 0;
    }
    for (int i = 0; i < num; i++)
    {
        uint32_t data_word = readread(uart);
        mem_write_word(MEM_SEGMENT_READ_DATA_OFFSET, idx_read, data_word);
        idx_read++;
    }
    return num;
}

void receive_and_send_output_matrix(Uart &uart, uint32_t addr_width, uint32_t *idx_matrix_i, uint32_t *idx_matrix_j)
{
    uint32_t tmp = 1;
    for (uint32_t i = 0; i < addr_width; i++)
    {
        tmp *= 2;
    }
    addr_width = tmp * 16;

    for (int word_in_reg_idx = 0; word_in_reg_idx < OUTPUT_REGISTER_SIZE_WORDS; ++word_in_reg_idx)
    {
        for (volatile int delay = 0; delay < 100000; ++delay) // x10 times normal delay
            ;                                                 // Delay to allow UART to process previous data
        uart.write(CMD_WRITE_MATRIX);
        send_word(uart, *(idx_matrix_i));
        send_word(uart, *(idx_matrix_j));
        for (int matrix_reg_idx = 0; matrix_reg_idx < NUM_OUTPUT_REGISTERS; ++matrix_reg_idx)
        {
            uint32_t current_matrix_reg_base_offset = MEM_SEGMENT_MATRIX_BASE_OFFSET + (matrix_reg_idx * MATRIX_REG_WORD_STRIDE);
            uint32_t data_word = mem_read_word(current_matrix_reg_base_offset, word_in_reg_idx);
            send_word(uart, data_word);
            // Delay after sending the command byte to allow receiver to process
        }
        if (*(idx_matrix_j) == addr_width)
        {
            *(idx_matrix_j) = 0;
            *(idx_matrix_i) += 16;
        }
        else
        {
            *(idx_matrix_j) += 1;
        }
    }
}

// --- Memory Access Function Implementations ---

// Helper macro to get the volatile pointer to a specific memory word
// Note: The multiplication by 4 is to convert word offset to byte offset,
// but pointer arithmetic on uint32_t* already handles this.
// So, (segment_offset + word_offset) is the direct word offset from AXI_MEMORY_BASE_ADDR.
#define MEM_WORD_PTR(segment_offset, word_offset) \
    ((volatile uint32_t *)(DNA_DATA_MEMORY_BASE_ADDR + ((segment_offset + word_offset) * 4)))

// Corrected version for direct pointer arithmetic:
// ((volatile uint32_t*)AXI_MEMORY_BASE_ADDR + (segment_offset + word_offset))

// Using the version that explicitly calculates byte offset for clarity with original mem.c intent
// If AXI_MEMORY_BASE_ADDR is already (volatile uint32_t*), then pointer arithmetic is simpler.
// Assuming AXI_MEMORY_BASE_ADDR is a numerical address:

uint32_t mem_read_word(uint32_t segment_base_word_offset, uint32_t word_offset_in_segment)
{
    uint32_t absolute_word_offset = segment_base_word_offset + word_offset_in_segment;
    return *(((volatile uint32_t *)DNA_DATA_MEMORY_BASE_ADDR) + absolute_word_offset);
}

void mem_write_word(uint32_t segment_base_word_offset, uint32_t word_offset_in_segment, uint32_t data)
{
    uint32_t absolute_word_offset = segment_base_word_offset + word_offset_in_segment;
    volatile uint32_t *address_to_write = ((volatile uint32_t *)DNA_DATA_MEMORY_BASE_ADDR) + absolute_word_offset;
    *address_to_write = data;
}

uint32_t mem_read_bits(uint32_t segment_base_word_offset, uint32_t word_offset_in_segment, uint8_t start_bit, uint8_t num_bits)
{
    if (num_bits == 0 || num_bits > 32 || start_bit >= 32 || (start_bit + num_bits) > 32)
    {
        // Handle error appropriately, e.g., return 0 or an error code
        return 0; // Or some error indicator
    }

    uint32_t full_word = mem_read_word(segment_base_word_offset, word_offset_in_segment);
    uint32_t mask = (num_bits == 32) ? 0xFFFFFFFF : ((1UL << num_bits) - 1);

    return (full_word >> start_bit) & mask;
}

void mem_write_bits(uint32_t segment_base_word_offset, uint32_t word_offset_in_segment, uint32_t data_to_write, uint8_t start_bit, uint8_t num_bits)
{
    if (num_bits == 0 || num_bits > 32 || start_bit >= 32 || (start_bit + num_bits) > 32)
    {
        // Handle error or return
        return;
    }

    uint32_t absolute_word_offset = segment_base_word_offset + word_offset_in_segment;
    volatile uint32_t *reg_ptr = ((volatile uint32_t *)DNA_DATA_MEMORY_BASE_ADDR) + absolute_word_offset;

    uint32_t current_value = *reg_ptr;

    uint32_t field_mask = (num_bits == 32) ? 0xFFFFFFFF : ((1UL << num_bits) - 1);
    uint32_t clear_mask = ~(field_mask << start_bit);

    uint32_t value_with_bits_cleared = current_value & clear_mask;
    uint32_t shifted_new_data = (data_to_write & field_mask) << start_bit;

    uint32_t final_value_to_write = value_with_bits_cleared | shifted_new_data;
    *reg_ptr = final_value_to_write;
}