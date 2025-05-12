#include "uart.hpp"

Uart::Uart(uint32_t base){
    base_addr = (volatile uint32_t*)base;
}

void Uart::write_reg(uint32_t offset, uint32_t value){
    *(base_addr + offset) = value;
}

uint32_t Uart::read_reg(uint32_t offset){
    return *(base_addr + offset);
}

void Uart::init(uint32_t clk_freq, uint32_t baud_rate){
    //Tính giá trị dvsr: dvsr = (clk_freq / (16 * baud_rate)) - 1
    uint32_t dvsr = (clk_freq / (16 * baud_rate)) - 1;
    write_reg(UART_DVSR_REG - UART_BASE_ADDR, dvsr & 0x7FF); // Giới hạn 11 bit
}

void Uart::write(uint8_t data){
    //cho neu TX day
    while(read_reg(UART_RX_REG - UART_BASE_ADDR) & UART_TX_FULL){}
    write_reg(UART_TX_REG - UART_BASE_ADDR, data);
}

int16_t Uart::read(){
    uint32_t status = read_reg(UART_RX_REG - UART_BASE_ADDR);
    if (status & UART_RX_EMPTY){
        return -1;
    
    }
    return status & UART_DATA_MASK;
}

bool Uart::is_tx_full(){
    return (read_reg(UART_RX_REG - UART_BASE_ADDR) & UART_TX_FULL) != 0;

}

bool Uart::is_rx_empty(){
    return (read_reg(UART_RX_REG - UART_BASE_ADDR) & UART_RX_EMPTY) != 0;

}

void Uart::write_string(const char* str){
    while (*str){
        write(*str++);
    }
}

