`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 10.06.2026 18:23:18
// Design Name: 
// Module Name: APB_Slave
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


module APB_Slave(input pclk,prst,input psel,penable,pwrite,output reg [31:0] prdata,output reg pready,input [7:0] pwaddr,input [31:0] pwdata);
reg [31:0] mem [0:15];
always@(posedge pclk or posedge prst)
begin
  if(prst) begin
     prdata<=0;
     pready<=1;
  end
  else begin
    if(psel && penable) begin
    if(pwrite) begin
       mem[pwaddr[3:0]]<=pwdata;
       end
    else begin
      prdata<=mem[pwaddr[3:0]];
    end
    end
  end
end
endmodule
