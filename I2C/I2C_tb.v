`timescale 1ns / 1ps
module I2C_tb;

reg clk, rst, start;
reg [7:0] data_in;
reg [6:0] addr;
reg rw;
//reg slave_sda;      // FIX 1: reg, not wire - slave drives SDA

wire sda_out, scl, sda_en;

// FIX 2: correct SDA bus - master drives when sda_en=1, slave drives when master releases
wire sda = sda_en ? sda_out : 1'bz;

top_module dut (
    .clk(clk), .rst(rst), .start(start),
    .sda(sda), .data_in(data_in),
    .sda_out(sda_out), .scl(scl), .sda_en(sda_en),
    .addr(addr), .rw(rw)
);

always #5 clk = ~clk;

initial begin
    clk = 0; rst = 1; start = 0;
              // bus idle high
    data_in = 8'hA5;
    addr    = 7'h55;
    rw      = 0;
    #20 rst   = 0;
    #20 start = 1;
    #10 start = 0;
end

// FIX 3: ACK drives on SCL low (setup before SCL rises), not on posedge scl
// slave pulls SDA low only during ACK state, releases otherwise

initial begin
    $monitor("time=%0t state=%0d scl=%b sda=%b done=%b",
              $time, dut.state, scl, sda, dut.done);
    #150000;
    $finish;
end

endmodule