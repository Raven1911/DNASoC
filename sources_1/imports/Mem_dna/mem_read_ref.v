`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 09:43:10 PM
// Design Name: 
// Module Name: mem_reg
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module mem_read_ref #(
    parameter MEM_SIZE = 4096, // 4KB
    parameter ADDR_WIDTH = 32,
    parameter DATA_WIDTH = 32

)(
    input clk,
    // input [3:0] wen,
    input                   we_A, we_B,
    input [ADDR_WIDTH-1:0]  addr_A, addr_B,
    input [ADDR_WIDTH-1:0]  addw_A, addw_B,
    input [DATA_WIDTH-1:0]  din_A, din_B,
    output reg [DATA_WIDTH-1:0] dout_A, dout_B

    );

    //big endian
    reg [DATA_WIDTH-1:0] memory [0:(MEM_SIZE >> 2) - 1];


    // Port A
    always @(posedge clk) begin
        dout_A <= memory[addr_A >> 2];
        if (we_A) begin
            memory[addw_A >> 2] = din_A;
        end
    end

    // Port B
    always @(posedge clk) begin
        dout_B <= memory[addr_B >> 2];
        if (we_B) begin
            memory[addw_B >> 2] = din_B;
        end
    end


    
endmodule