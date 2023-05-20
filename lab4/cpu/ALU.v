`timescale 1ns / 1ps

module ALU (
    input [3:0] alu_ctrl,
    input [31:0] alu_op1,
    input [31:0] alu_op2,
    output reg [31:0] alu_res
);
    always @(*) begin
        // assign `alu_res`
        case (alu_ctrl)
            4'b0000: alu_res = alu_op1 + alu_op2;
            4'b0001: alu_res = alu_op1 - alu_op2;
            4'b0010: alu_res = alu_op1 == alu_op2;
            4'b0011: alu_res = alu_op1 < alu_op2; // Unsigned alu_op1 < alu_op2
            4'b0100: alu_res = ($signed(alu_op1)) < ($signed(alu_op2)); // Signed alu_op1 < alu_op2
            4'b0101: alu_res = alu_op1 & alu_op2;
            4'b0110: alu_res = alu_op1 | alu_op2;
            4'b0111: alu_res = alu_op1 ^ alu_op2;
            4'b1000: alu_res = alu_op1 >> alu_op2;
            4'b1001: alu_res = alu_op1 << alu_op2;
            4'b1010: alu_res = alu_op2; // Pass op2
            default: alu_res = 0;
        endcase
    end

endmodule