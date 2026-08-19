`timescale 1ns / 1ps

module AHB_tb;

reg hclk;
reg hrst;

// Wires to observe DUT signals
wire [31:0] haddr;
wire [31:0] hwdata;
wire        hwrite;
wire [1:0]  htrans;
wire [31:0] hrdata;
wire        hreadyout;

// Instantiate Top Module
top_module DUT (
    .hclk(hclk),
    .hrst(hrst)
);

// --------------------------------------------------
// Connect internal DUT signals for monitoring
// --------------------------------------------------

assign haddr     = DUT.haddr;
assign hwdata    = DUT.hwdata;
assign hwrite    = DUT.hwrite;
assign htrans    = DUT.htrans;
assign hrdata    = DUT.hrdata;
assign hreadyout = DUT.hreadyout;


// --------------------------------------------------
// Clock Generation
// --------------------------------------------------

initial begin
    hclk = 1'b0;

    forever #5 hclk = ~hclk;
end


// --------------------------------------------------
// Reset and Simulation Control
// --------------------------------------------------

initial begin

    hrst = 1'b1;

    #20;

    hrst = 1'b0;

    #200;

    $finish;

end


// --------------------------------------------------
// AHB Signal Monitor
// --------------------------------------------------

initial begin

    $monitor(
        "TIME=%0t | HCLK=%b | RESET=%b | HADDR=%h | HWDATA=%h | HWRITE=%b | HTRANS=%b | HRDATA=%h | HREADYOUT=%b",
        $time,
        hclk,
        hrst,
        haddr,
        hwdata,
        hwrite,
        htrans,
        hrdata,
        hreadyout
    );

end


// --------------------------------------------------
// Optional: Display only at positive clock edge
// --------------------------------------------------

always @(posedge hclk) begin

    $display(
        "-------------------------------------------------------------"
    );

    $display(
        "TIME=%0t | HADDR=%h | HWDATA=%h | HWRITE=%b | HTRANS=%b | HRDATA=%h | HREADYOUT=%b",
        $time,
        haddr,
        hwdata,
        hwrite,
        htrans,
        hrdata,
        hreadyout
    );

end

endmodule