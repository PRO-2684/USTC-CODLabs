`timescale 1ns / 1ps

module CTRL (
    input [31:0] inst,
    output jal, jalr,
    output reg [2:0] br_type,
    output reg wb_en,
    output reg [1:0] wb_sel,
    output alu_op1_sel, alu_op2_sel,
    output reg [3:0] alu_ctrl,
    output [2:0] imm_type,
    output mem_we
);
    // Support add, addi, lui, auipc, beq, blt, jal, jalr, lw, sw
    // TODO: Support .sub, .and, .or; .bne, .bge, .bltu, .bgeu; sll, slli, srl, srli
    // Opcodes
    parameter ARITH = 7'b0110011; // add, sub, and, or
    parameter ARITHI = 7'b0010011;
    parameter LUI = 7'b0110111;
    parameter AUIPC = 7'b0010111;
    parameter BR = 7'b1100011;
    parameter JAL = 7'b1101111;
    parameter JALR = 7'b1100111;
    parameter LW = 7'b0000011;
    parameter SW = 7'b0100011;
    // Branch types
    parameter BEQ_type = 3'b000;
    parameter BNE_type = 3'b001;
    parameter BLT_type = 3'b010;
    parameter BGE_type = 3'b011;
    parameter BLTU_type = 3'b100;
    parameter BGEU_type = 3'b101;
    parameter NO_BR = 3'b111;
    // Immediate types
    // Shift types
    parameter SHIFT_LEFT = 1'b0;
    parameter SHIFT_RIGHT = 1'b1;

    wire [6:0] opcode;
    assign opcode = inst[6:0];
    // [jal, jalr] Jump control: jal, jalr
    assign jal = (opcode == JAL);
    assign jalr = (opcode == JALR);
    // [br_type] Branch control: beq, blt
    always @(*) begin
        // if (opcode == BR && inst[14:12] == 3'b000) br_type = BEQ_type;
        // else if (opcode == BR && inst[14:12] == 3'b100) br_type = BLT_type;
        // else br_type = NO_BR;
        if (opcode == BR) begin
            case (inst[14:12])
                3'b000: br_type = BEQ_type;
                3'b001: br_type = BNE_type;
                3'b100: br_type = BLT_type;
                3'b101: br_type = BGE_type;
                3'b110: br_type = BLTU_type;
                3'b111: br_type = BGEU_type;
                default: br_type = NO_BR;
            endcase
        end else br_type = NO_BR;
    end
    // [wb_en, wb_sel] Write registers: arith, addi, auipc, lui, lw, jal, jalr
    always @(*) begin
        case (opcode)
            ARITH: begin wb_sel = 0; wb_en = 1; end
            ARITHI: begin wb_sel = 0; wb_en = 1; end
            AUIPC: begin wb_sel = 0; wb_en = 1; end
            LUI: begin wb_sel = 3; wb_en = 1; end
            LW: begin wb_sel = 2; wb_en = 1; end
            JAL: begin wb_sel = 1; wb_en = 1; end
            JALR: begin wb_sel = 1; wb_en = 1; end
            default: begin wb_sel = 0; wb_en = 0; end
        endcase
    end
    // [alu_op1_sel] ALU operator 1 source (0 for register file)
    // arith, addi, shift, shift_i, lui, jalr, lw, sw from register; beq, blt, auipc, jal from pc
    assign alu_op1_sel = (opcode == BR || opcode == AUIPC || opcode == JAL);
    // [alu_op2_sel] ALU operator 2 source (0 for register file)
    // arith, shift from register
    assign alu_op2_sel = ~(opcode == ARITH);
    // [alu_ctrl] Operating mode: add / pass2 / other
    always @(*) begin
        if (opcode == LUI)
            alu_ctrl = 4'b1010; // Pass op2
        else if (opcode == ARITH)
             case ({inst[31:25], inst[14:12]})
                10'b0100000000: alu_ctrl = 4'b0001; // Sub
                10'b0000000111: alu_ctrl = 4'b0101; // And
                10'b0000000110: alu_ctrl = 4'b0110; // Or
                10'b0000000001: alu_ctrl = 4'b1001; // Sll
                10'b0000000101: alu_ctrl = 4'b1000; // Srl
                default: alu_ctrl = 4'b0000; // Add
             endcase
        else if (opcode == ARITHI) begin
             case ({inst[31:25], inst[14:12]})
                10'b0000000001: alu_ctrl = 4'b1001; // Slli
                10'b0000000101: alu_ctrl = 4'b1000; // Srli
                default: alu_ctrl = 4'b0000; // Add
             endcase
        end else
            alu_ctrl = 4'b0000; // Add
    end
    // [imm_type]
    assign imm_type = 0; // TODO: Port imm_type logic from `Immediate.v`
    // [mem_we]
    assign mem_we = (opcode == SW);
endmodule