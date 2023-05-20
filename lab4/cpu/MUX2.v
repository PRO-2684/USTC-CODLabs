`timescale 1ns / 1ps

module MUX2 (
    input [31:0] src0,
    input [31:0] src1,
    input [31:0] src2,
    input [31:0] src3,
    input [1:0] sel,
    output reg [31:0] res
);
    always @(*) begin
        case (sel)
            0: res = src0;
            1: res = src1;
            2: res = src2;
            3: res = src3;
            default: res = 0;
        endcase
    end
endmodule