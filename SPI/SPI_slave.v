`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 11.05.2026 22:58:20
// Design Name: 
// Module Name: SPI_slave
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


module SPI_slave(input rst,mosi,sclk,sc,input [7:0] tx_transfer,output reg miso,output reg [7:0] data_out);
reg done;
reg busy;
reg [7:0] shift_reg;
reg [3:0] counter;
reg [7:0] tx_shift_reg;
reg sc_prev;
always@(posedge sclk or posedge rst)
begin
  if(rst) begin
    done<=0;
    busy<=0;
    shift_reg<=0;
    data_out<=0;
    counter<=0;
   end
   else begin
      if(sc==0) begin
        busy<=1;
        shift_reg<={shift_reg[6:0],mosi};
        if(counter==7) begin
          data_out <= {shift_reg[6:0], mosi};
          busy<=0;
          done<=1;
          counter<=0;
        end
        else begin
          counter<=counter+1;
        end  
      end
      else begin
        busy<=0;
        counter<=0;
      end
      if(done) begin
        done<=0;
      end  
   end 
end
always@(negedge sclk or negedge sc or posedge rst) begin
    if(rst) begin
        miso <= 0;
        tx_shift_reg <= 0;
        sc_prev <= 1;
    end
    else begin
        sc_prev <= sc;
        if(sc_prev && !sc) begin          
            tx_shift_reg <= tx_transfer;
            miso <= tx_transfer[7];
        end
        else if(!sc) begin
            tx_shift_reg <= tx_shift_reg << 1;
            miso <= tx_shift_reg[6];
        end
    end
end
endmodule
