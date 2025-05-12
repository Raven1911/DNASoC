`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 05/06/2025 09:08:48 PM
// Design Name: 
// Module Name: DNA_SoC_tb
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



module DNA_SoC_tb(

    );

    reg clk, resetn;
    wire trap;
    //gpio uart0
    reg rx0;
    wire tx0;

    //port spi0
    wire                          spi0_clk;
    wire                          spi0_mosi;
    reg                           spi0_miso;
    wire     [1:0]                spi0_ss_n;

    DNA_SoC Top_Module(
    .clk125mhz(clk),
    .resetn(resetn),
    .trap(trap),
    
    //uart0
    .rx0(rx0),
    .tx0(tx0),
    //spi0
    .spi0_clk(spi0_clk),
    .spi0_mosi(spi0_mosi),
    .spi0_miso(spi0_miso),
    .spi0_ss_n(spi0_ss_n)

    
    );

    always #4 clk = ~clk; // 125MHz clock

    initial begin
        resetn = 0;
        clk = 0;
        //#10 resetn = 1;
        #1000 resetn = 0;
        #1000 resetn = 1;

        #100000 $finish;
    end


endmodule
