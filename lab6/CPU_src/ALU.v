`timescale 1ns / 1ps

module ALU (
    input [3:0] alu_func,
    input [31:0] alu_src1,
    input [31:0] alu_src2,
    output reg [31:0] alu_ans
);
    always @(*) begin
        // assign `alu_ans`
        case (alu_func)
            4'b0000: alu_ans = alu_src1 + alu_src2;
            4'b0001: alu_ans = alu_src1 - alu_src2;
            4'b0010: alu_ans = alu_src1 == alu_src2;
            4'b0011: alu_ans = alu_src1 < alu_src2; // Unsigned alu_src1 < alu_src2
            4'b0100: alu_ans = ($signed(alu_src1)) < ($signed(alu_src2)); // Signed alu_src1 < alu_src2
            4'b0101: alu_ans = alu_src1 & alu_src2;
            4'b0110: alu_ans = alu_src1 | alu_src2;
            4'b0111: alu_ans = alu_src1 ^ alu_src2;
            4'b1000: alu_ans = alu_src1 >> alu_src2;
            4'b1001: alu_ans = alu_src1 << alu_src2;
            4'b1010: alu_ans = alu_src2; // Pass op2
            4'b1011: alu_ans = $signed(alu_src1) >>> alu_src2[5:0];
            default: alu_ans = 0;
        endcase
    end

endmodule