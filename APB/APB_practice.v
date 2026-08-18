`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 18:22:24
// Design Name: 
// Module Name: APB_practice
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


module APB_practice(
    input pclk,
    input prst,
    input [7:0] user_pwaddr,
    input [31:0] user_pwdata
);

wire psel;
wire penable;
wire pwrite;
wire [7:0] pwaddr;
wire [31:0] pwdata;
wire [31:0] prdata;
wire pready;
APB_Master master(
    .pclk(pclk),
    .prst(prst),
    .user_pwaddr(user_pwaddr),
    .user_pwdata(user_pwdata),
    .psel(psel),
    .penable(penable),
    .pwrite(pwrite),
    .pwaddr(pwaddr),
    .pwdata(pwdata),
    .prdata(prdata),
    .pready(pready)
);
APB_Slave slave(
    .pclk(pclk),
    .prst(prst),
    .psel(psel),
    .penable(penable),
    .pwrite(pwrite),
    .prdata(prdata),
    .pready(pready),
    .pwaddr(pwaddr),
    .pwdata(pwdata)
);
endmodule
