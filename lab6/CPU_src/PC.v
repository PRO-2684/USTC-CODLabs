`timescale 1ns / 1ps

module PC (
    input clk,
    input rst,
    input stall,
    input [31:0] pc_next,
    output reg [31:0] pc_cur
);
    initial begin
        pc_cur = 32'h2ffc;
    end
    always @(posedge clk) begin
        if (rst)
            pc_cur <= 32'h2ffc;
        else if (~stall)
            pc_cur <= pc_next;
    end
endmodule