`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 19:38:48
// Design Name: 
// Module Name: AHB_Master
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


module AHB_Master_1(input hclk,hrst,output reg [31:0] haddr,output reg [31:0] hwdata,output reg hwrite,output reg [1:0] htrans,input [31:0] hrdata,input hreadyout);
reg [1:0] state;
parameter IDLE=1;
parameter WRITE=2;
parameter READ=3;
always@(posedge hclk or posedge hrst)
begin
  if(hrst) begin
    state<=IDLE;
    haddr<=0;
    hwdata<=0;
    hwrite<=0;
    htrans<=2'b00;
  end
  else begin
  case(state)
   IDLE: begin
     haddr<=32'h5;
     hwdata<=32'h12345678;
     hwrite<=1;
     htrans<=2'b10;
     state<=WRITE;
   end
   WRITE: begin
     if(hreadyout) begin
       haddr<=32'h5;
       hwrite<=0;
       htrans<=2'b10;
       state<=READ;
     end
   end
   READ: begin
     if(hreadyout) begin
       htrans<=2'b00;
     end
   end
  endcase
  end
end
endmodule
