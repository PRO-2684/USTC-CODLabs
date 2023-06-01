`timescale 1ns / 1ps

module CTRL (
    input [31:0] inst,
    output rf_re0,
    output rf_re1,
    output reg [1:0] rf_wd_sel,
    output rf_we,
    output [2:0] imm_type,
    output alu_src1_sel, alu_src2_sel,
    output reg [3:0] alu_func,
    output jal, jalr,
    output reg [2:0] br_type,
    output mem_we,
    output ebreak
);
    // 在读寄存器 rs 为 x0 时, 将 rf_re 设置为 0
    assign rf_re0 = |inst[19:15];
    assign rf_re1 = |inst[24:20];
    // Support add, addi, lui, auipc, beq, blt, jal, jalr, lw, sw
    // Support .sub, .and, .or; .bne, .bge, .bltu, .bgeu; sll, slli, srl, srli
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
    parameter EBREAK = 7'b1110011;
    // Branch types
    parameter BEQ_type = 3'b110;
    parameter BNE_type = 3'b001;
    parameter BLT_type = 3'b010;
    parameter BGE_type = 3'b011;
    parameter BLTU_type = 3'b100;
    parameter BGEU_type = 3'b101;
    parameter NO_BR = 3'b000;

    wire [6:0] opcode;
    assign opcode = inst[6:0];
    // [jal, jalr] Jump control: jal, jalr
    assign jal = (opcode == JAL);
    assign jalr = (opcode == JALR);
    // [br_type] Branch control: beq, blt
    always @(*) begin
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
    // [rf_we, rf_wd_sel] Write registers: arith, addi, auipc, lui, lw, jal, jalr
    // 在写寄存器 rd 为 x0 时, 将 rf_we 设置为 0
    assign rf_we = (|inst[11:7]) & (opcode == ARITH | opcode == ARITHI | opcode == AUIPC | opcode == LUI | opcode == LW | opcode == JAL | opcode == JALR);

    always @(*) begin
        case (opcode)
            ARITH: rf_wd_sel = 0;
            ARITHI: rf_wd_sel = 0;
            AUIPC: rf_wd_sel = 0;
            LUI: rf_wd_sel = 3;
            LW: rf_wd_sel = 2;
            JAL: rf_wd_sel = 1;
            JALR: rf_wd_sel = 1;
            default: rf_wd_sel = 0;
        endcase
    end
    // [alu_src1_sel] ALU operator 1 source (0 for register file)
    // arith, addi, shift, shift_i, lui, jalr, lw, sw from register; beq, blt, auipc, jal from pc
    assign alu_src1_sel = (opcode == BR || opcode == AUIPC || opcode == JAL);
    // [alu_src2_sel] ALU operator 2 source (0 for register file)
    // arith, shift from register
    assign alu_src2_sel = ~(opcode == ARITH);
    // [alu_func] Operating mode: add / pass2 / other
    always @(*) begin
        if (opcode == LUI)
            alu_func = 4'b1010; // Pass op2
        else if (opcode == ARITH || opcode == ARITHI)
             case ({inst[31:25], inst[14:12]})
                10'b0100000000: alu_func = 4'b0001; // Sub
                10'b0000000111: alu_func = 4'b0101; // And
                10'b0000000110: alu_func = 4'b0110; // Or
                10'b0000000001: alu_func = 4'b1001; // Sll(i)
                10'b0000000101: alu_func = 4'b1000; // Srl(i)
                10'b0100000101: alu_func = 4'b1011; // Sra(i)
                default: alu_func = 4'b0000; // Add
             endcase
        // else if (opcode == ARITHI)
        //      case ({inst[31:25], inst[14:12]})
        //         10'b0000000001: alu_func = 4'b1001; // Slli
        //         10'b0000000101: alu_func = 4'b1000; // Srli
        //         10'b0100000101: alu_func = 4'b1011; // Srai
        //         default: alu_func = 4'b0000; // Add
        //      endcase
        else
            alu_func = 4'b0000; // Add
    end
    // [imm_type] COmpleted at `Immediate.v`
    assign imm_type = 0;
    // [mem_we]
    assign mem_we = (opcode == SW);
    // [ebreak]
    assign ebreak = (opcode == EBREAK);
endmodule