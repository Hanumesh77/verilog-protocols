`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2026 22:39:20
// Design Name: 
// Module Name: SPI_master
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


module SPI_master(input clk,rst,start,miso,input [7:0] data_in,output reg sclk,mosi,done,sc,output reg [7:0] data_out);
reg busy;
reg [3:0] counter;
reg [7:0] shift_reg;
reg [7:0] rx_shift_reg;
always@(posedge clk or posedge rst)
begin
  if(rst) begin
    sclk<=0;
    done<=0;
    busy<=0;
    counter<=0;
    shift_reg<=0;
    sc<=1;
    mosi<= 0;
    rx_shift_reg <= 0;
    data_out<= 0;
  end  
  else
  begin
  done<=0;
    if(start && !busy) begin
      counter<=0;
      shift_reg<=data_in;
      busy<=1;
      done<=0;
    end
    if(busy) begin
       sc<=0;
       sclk<=~sclk;
       if(sclk==0)begin
       mosi<=shift_reg[7];
       shift_reg<=shift_reg<<1;
       if(counter==7) begin
         busy<=0;
         done<=1;
         sc<=1;
         counter<=0;
         sclk<=0;
         end
         else
         begin
         done<=0;
           counter<=counter+1;
         end 
         end 
         if(sclk==1) begin      
           rx_shift_reg<={rx_shift_reg[6:0],miso};
           if(counter==7)
           data_out<={rx_shift_reg[6:0],miso};
         end
      end
   end
end
endmodule
