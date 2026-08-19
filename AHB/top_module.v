`timescale 1ns / 1ps    

module top_module(
    input hclk,
    input hrst
);

wire [31:0] haddr;
wire [31:0] hwdata;
wire hwrite;
wire [1:0] htrans;
wire [31:0] hrdata;
wire hreadyout;

AHB_Master_1 master(
    .hclk(hclk),
    .hrst(hrst),
    .haddr(haddr),
    .hwdata(hwdata),
    .hwrite(hwrite),
    .htrans(htrans),
    .hrdata(hrdata),
    .hreadyout(hreadyout)
);

AHB_Slave slave(
    .hclk(hclk),
    .hrst(hrst),
    .haddr(haddr),
    .hwdata(hwdata),
    .hwrite(hwrite),
    .htrans(htrans),
    .hrdata(hrdata),
    .hreadyout(hreadyout)
);

endmodule