`timescale 1ns / 1ps

module Immediate (
    input [2:0] imm_type,
    input [31:0] inst,
    output reg [31:0] imm
);
    // Support addi, lui, auipc, beq, blt, jal, jalr, lw, sw

    // Judge opcode
    wire [6:0] opcode = inst[6:0];

    // Immediate value for different instruction types
    wire [31:0] imm_i = {{20{inst[31]}}, inst[31:20]};
    wire [31:0] imm_r = {{20{inst[31]}}, inst[31:25], inst[11:7]};
    wire [31:0] imm_b = {{20{inst[31]}}, inst[7], inst[30:25], inst[11:8], 1'b0};
    wire [31:0] imm_j = {{12{inst[31]}}, inst[19:12], inst[20], inst[30:21], 1'b0};
    wire [31:0] imm_u = {inst[31:12], 12'b0};

    // Immediate value gen
    always @(*) begin
        imm = 0;
        case (opcode)
            7'b0010011: imm = imm_i; // addi (I-type)
            7'b0110111: imm = imm_u; // lui (U-type)
            7'b0000011: imm = imm_i; // lw (I-type)
            7'b1100111: imm = imm_i; // jalr (I-type)
            7'b0100011: imm = imm_r; // sw (R-type)
            7'b1100011: imm = imm_b; // branch (B-type)
            7'b1101111: imm = imm_j; // jal (J-type)
            7'b0010111: imm = imm_u; // auipc (U-type)
            default: imm = 0;
        endcase
    end

endmodule