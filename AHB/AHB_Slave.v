`timescale 1ns / 1ps

module AHB_Slave(
    input hclk,
    input hrst,

    input [31:0] haddr,
    input [31:0] hwdata,
    input hwrite,
    input [1:0] htrans,

    output reg [31:0] hrdata,
    output reg hreadyout
);

reg [31:0] mem [0:15];
integer i;

always @(posedge hclk or posedge hrst) begin

    if (hrst) begin

        hreadyout <= 1'b1;
        hrdata    <= 32'b0;

        for (i = 0; i < 16; i = i + 1)
            mem[i] <= 32'b0;

    end

    else begin

        // Valid AHB transfer
        if (htrans == 2'b10 || htrans == 2'b11) begin

            // WRITE
            if (hwrite) begin
                mem[haddr[3:0]] <= hwdata;
            end

            // READ
            else begin
                hrdata <= mem[haddr[3:0]];
            end

        end

    end

end

endmodule