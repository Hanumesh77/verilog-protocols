`timescale 1ns / 1ps                     
module UART_rx_(
    input clk,
    input rst,
    input baud,
    input rx,
    output reg [10:0] frame,
    output reg [7:0] data_out,
    output reg done
);
reg busy;
reg [3:0] counter;
reg half_bit;

always @(posedge clk or posedge rst)
begin
    if(rst)
    begin
        busy      <= 0;
        done      <= 0;
        counter   <= 0;
        frame     <= 11'b0;
        data_out  <= 0;
        half_bit  <= 0;
    end
    else
    begin
        done <= 0;

        if(rx == 0 && !busy)
        begin
            busy     <= 1;
            counter  <= 0;
            half_bit <= 1;
        end
        else if(busy && half_bit && baud)
        begin
            half_bit <= 0;
        end
        else if(busy && !half_bit && baud)
        begin
            frame[counter] <= rx;
            if(counter == 10)
            begin
                busy    <= 0;
                done    <= 1;
                counter <= 0;
            end
            else
                counter <= counter + 1;
        end
    end
end

always @(posedge clk)
begin
    if(done)
    begin
        
        if(frame[0] == 1'b0 && frame[10] == 1'b1)
           //data_out <= frame[8:1];
           data_out <= {frame[1], frame[2], frame[3], frame[4], frame[5], frame[6], frame[7], frame[8]};
    end
end

endmodule