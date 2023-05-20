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
    input [31:0] wd
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
    // Read
    assign rd0 = data[ra0], rd1 = data[ra1], rd_dbg = data[ra_dbg];
    // Write
    always @(posedge clk) begin
        if (we & ( | wa)) // Forbid writing x0
            data[wa] <= wd;
    end
endmodule