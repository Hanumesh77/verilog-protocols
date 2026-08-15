`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 12:18:16
// Design Name: 
// Module Name: UART_baud_rate
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


module UART_baud(input clk,rst,output reg [4:0] count,output reg baud);
always@(posedge clk or posedge rst)
begin
   if(rst)
   begin
     count<=0;
     baud<=0;
   end
   else if(count==10)
   begin
     count<=0;
     baud<=1;
   end  
   else begin
     count<=count+1;
     baud<=0;
   end
 end          
endmodule
