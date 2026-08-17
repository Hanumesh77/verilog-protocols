`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 15.05.2026 23:26:44
// Design Name: 
// Module Name: top_module
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


module top_module(input clk,rst,start,inout sda,input [7:0] data_in,output reg sda_out,scl,sda_en,input [6:0] addr,input rw);
reg [7:0] shift_reg;
reg done;
reg busy;
reg [3:0] counter;
reg [8:0] div_counter;
reg ack;
reg [2:0] state;
parameter IDLE=3'd0;
parameter START=3'd1;
parameter ADDRESS=3'd2;
parameter ACK=3'd3;
parameter DATA=3'd4;
parameter STOP=3'd5;
assign sda=sda_en?sda_out:1'bz;
always@(posedge clk or posedge rst)
begin
  if(rst) begin
    sda_en<=0;
    sda_out<=0;
    done<=0;
    busy<=0;
    scl<=1;
    counter<=0;
    div_counter<=0;
    shift_reg<=0;
    ack<=0;
    state<=IDLE;
  end
  else begin
  done<=0;
    if(busy && div_counter==249) begin
      scl<=~scl;
      div_counter<=0;
    end
    else begin
      div_counter<=div_counter+1;
    end
   case(state)
   IDLE: begin
     if(start) begin
       busy<=1;
       shift_reg<={addr,rw};
       counter<=7;
       state<=START;
     end
   end
   START: begin
     if(busy && scl==1) begin
       sda_en<=1;
       sda_out<=0;
       state<=ADDRESS;
     end
   end
   ADDRESS: begin
     if(scl==0) begin
       sda_en<=1;
       sda_out<=shift_reg[8];
       shift_reg<=shift_reg<<1;
       if(counter==0) begin
         sda_en<=0;
         sda_out<=0;
         state<=ACK;
       end
       else begin
        counter<=counter-1;
       end
     end
   end
   ACK: begin
    if(scl==1) begin
      ack<=~sda;
      if(sda==0) begin
        ack<=1;
        shift_reg<=data_in;
        counter<=7;
        state<=DATA;
      end
    end
    else begin
          state<=STOP;
    end
   end
   DATA: begin
     if(scl==0) begin
      sda_en<=1;
      sda_out<=shift_reg[8];
      shift_reg<=shift_reg<<1;
      if(counter==0) begin
        sda_en<=0;
        sda_out<=0;
        state<=STOP;
      end
      else begin
        counter<=counter-1;
      end
     end
   end
   STOP: begin
     sda_en <= 1;   
    if(scl == 0) sda_out <= 0;
    else begin
        sda_out <= 1;   
        done <= 1;
        busy <= 0;
        state <= IDLE;
   end
   end
   endcase
end
end
endmodule
