`timescale 1ns / 1ps

module RF (
    input clk,
    input we,
    input [4:0] ra0,
    input [4:0] ra1,
    input [4:0] ra_dbg,
    output [31:0] rd0,
    output [31:0] rd1,
    output [31:0] rd_dbg,
    input [4:0] wa,
    input [31:0] wd,
    // Exception
    output [31:0] a0,
    output [31:0] t0
);
    reg [31:0] data [0:31];
    // Initialize
    integer i;
    initial begin
        i = 0;
        while (i < 32) begin
            data[i] = 32'b0;
            i = i + 1;
        end
        data[2] = 32'h2ffc;
        data[3] = 32'h1800;
    end
    wire we_ = we & ( | wa); // Corrected we signal (ignore we signal if wa == 0)
    // Write-first
    assign rd0 = ((ra0 == wa) && we_) ? wd : data[ra0];
    assign rd1 = ((ra1 == wa) && we_) ? wd : data[ra1];
    assign rd_dbg = ((ra_dbg == wa) && we_) ? wd : data[ra_dbg];
    assign a0 = ((5'd10 == wa) && we_) ? wd : data[10];
    assign t0 = ((5'd5 == wa) && we_) ? wd : data[5];
    // Write
    always @(posedge clk) begin
        if (we_) // Forbid writing x0
            data[wa] <= wd;
    end
endmodule
