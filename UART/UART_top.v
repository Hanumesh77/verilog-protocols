`timescale 1ns / 1ps
module UART_top(
    input clk,
    input rst,
    input start,
    input [7:0] data_in,
    input rx,
    output tx,
    output [7:0] data_out,
    output done
);
wire baud;
wire [4:0] count;
wire [10:0] frame;
wire busy_tx;
wire busy_rx;
UART_baud baud_gen(
    .clk(clk),
    .rst(rst),
    .count(count),
    .baud(baud)
);
UART_tx_ tx_unit(
    .clk(clk),
    .rst(rst),
    .baud(baud),
    .start(start),
    .start_bit(1'b0),   
    .stop_bit(1'b1),    
    .data(data_in),
    .frame(frame),
    .busy(busy_tx),
    .tx(tx)
);
UART_rx_ rx_unit(
    .clk(clk),
    .rst(rst),
    .baud(baud),
    .rx(rx),   
    .busy(busy_rx),
    .data_out(data_out),
    .done(done)
);
endmodule