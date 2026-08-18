`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 18:22:57
// Design Name: 
// Module Name: APB_Master
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


module APB_Master(input pclk,prst,input [7:0] user_pwaddr,input [31:0] user_pwdata,output reg psel,penable,pwrite,output reg [7:0] pwaddr,output reg [31:0] pwdata,input [31:0] prdata,input pready);
reg [1:0] state;
parameter IDEAL=1;
parameter SETUP=2;
parameter ACCESS=3;
always@(posedge pclk or posedge prst)
begin
  if(prst) begin
     psel<=0;
     penable<=0;
     pwrite<=0;
     pwaddr<=0;
     pwdata<=0;
     state<=IDEAL;
  end
  else begin
    case(state)
       IDEAL: begin //Write operation
         psel<=1;
         pwrite<=1;
         pwaddr<=user_pwaddr;
         pwdata<=user_pwdata;
         state<=SETUP;
       end
       SETUP: begin
         penable<=1;
         state<=ACCESS;
       end
       ACCESS: begin //Read opeartion
         if(pready) begin
           pwrite<=0;
           psel<=0;
           
           psel<=1;
           pwrite<=0;
           pwaddr<=8'h5;
           state<=SETUP;
         end
       end
    endcase
  end
end
endmodule
