`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2026 22:37:59
// Design Name: 
// Module Name: top_module
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


module top_module(input clk,rst,start,input [7:0] master_data_in,
    input [7:0] slave_data_in,
    output sclk,
    output sc,
    output mosi,
    output miso,
    output done,
    output [7:0] master_data_out,
    output [7:0] slave_data_out);
    
SPI_master master(
    .clk(clk),
    .rst(rst),
    .start(start),
    .miso(miso),
    .data_in(master_data_in),
    .sclk(sclk),
    .mosi(mosi),
    .done(done),
    .sc(sc),
    .data_out(master_data_out)
);

SPI_slave slave(
    .rst(rst),
    .mosi(mosi),
    .sclk(sclk),
    .sc(sc),
    .tx_transfer(slave_data_in),
    .miso(miso),
    .data_out(slave_data_out)
);
endmodule
