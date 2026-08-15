`timescale 1ns / 1ps 
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 21.04.2026 12:17:30
// Design Name: 
// Module Name: UART_tx_
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


module UART_tx_(input clk,rst,baud,start,start_bit,stop_bit,input [7:0] data,output reg [10:0] frame,output reg busy,output reg tx);
reg [3:0] i;
always@(posedge clk or posedge rst)
begin
  if(rst)
  begin
    frame<=0;
    tx<=1;
    busy<=0;
    i<=0;
  end
  else if(start && !busy)
  begin 
     frame<={stop_bit,~^data,data,start_bit};
     busy<=1;
     i<=0;
     tx<=1;
     end
  else if(baud && busy)
   begin 
      tx<=frame[i];
      i<=i+1;
      if(i==10)begin
         i<=0;
         tx<=1;
         busy<=0;
      end   
     end 
     else if(!busy)
       begin
           tx<=1;   
       end
  end             
endmodule
