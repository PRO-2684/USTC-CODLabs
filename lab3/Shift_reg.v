`timescale 1ns / 1ps

module Shift_reg(
    input rst,          // Button
    input clk,          // Work at 100MHz clock
    input [31:0] din,   // Data input  
    input [3:0] hex,    // Hexadecimal code for the switches
    input add,          // Add signal
    input del,          // Delete signal
    input set,          // Set signal
    output reg [31:0] dout  // Data output
);
    initial begin
        dout = 0;
    end
    always @(posedge clk) begin
        if (rst) begin
            dout <= 0;
        end else if (add) begin
            dout <= {dout[27:0], hex};
        end else if (del) begin
            dout <= dout >> 4;
        end else if (set) begin
            dout <= din;
        end
    end
endmodule

