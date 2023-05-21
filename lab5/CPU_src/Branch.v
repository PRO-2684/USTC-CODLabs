`timescale 1ns / 1ps

module Branch (
    input [31:0] op1,
    input [31:0] op2,
    input [2:0] br_type,
    output reg br
);
    parameter BEQ_type = 3'b110;
    parameter BNE_type = 3'b001;
    parameter BLT_type = 3'b010;
    parameter BGE_type = 3'b011;
    parameter BLTU_type = 3'b100;
    parameter BGEU_type = 3'b101;
    // parameter NO_BR = 3'b000;
    always @(*) begin
        case (br_type)
            BEQ_type: br = (op1 == op2);
            BNE_type: br = (op1 != op2);
            BLT_type: br = ($signed(op1) < $signed(op2));
            BGE_type: br = ($signed(op1) >= $signed(op2));
            BLTU_type: br = (op1 < op2);
            BGEU_type: br = (op1 >= op2);
            default: br = 0;
        endcase
    end
endmodule