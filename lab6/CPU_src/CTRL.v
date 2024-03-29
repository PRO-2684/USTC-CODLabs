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
    output reg [2:0] load_type,
    output load_sext,
    output reg [2:0] store_type,
    output ebreak
);
    // Support add, addi, lui, auipc, beq, blt, jal, jalr, lw, sw
    // Support .sub, .and, .or; .bne, .bge, .bltu, .bgeu; sll, slli, srl, srli
    // Opcodes
    parameter ARITH = 7'b0110011; // add, sub, and, or, shift, set
    parameter ARITHI = 7'b0010011; // *i
    parameter LUI = 7'b0110111;
    parameter AUIPC = 7'b0010111;
    parameter BR = 7'b1100011;
    parameter JAL = 7'b1101111;
    parameter JALR = 7'b1100111;
    parameter LOAD = 7'b0000011; // lw, lh(u), lb(u)
    parameter STORE = 7'b0100011; // sw, sh, sb
    parameter TRAP = 7'b1110011; // ebreak, csrrs
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
    // [ebreak]
    assign ebreak = (inst == 32'b000000000001_00000_000_00000_1110011);
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
    assign rf_we = (|inst[11:7]) & (opcode == ARITH || opcode == ARITHI || opcode == AUIPC || opcode == LUI || opcode == LOAD || opcode == JAL || opcode == JALR || (opcode == TRAP && ~ebreak));

    always @(*) begin
        case (opcode)
            ARITH: rf_wd_sel = 0;
            ARITHI: rf_wd_sel = 0;
            AUIPC: rf_wd_sel = 0;
            LUI: rf_wd_sel = 3;
            LOAD: rf_wd_sel = 2;
            JAL: rf_wd_sel = 1;
            JALR: rf_wd_sel = 1;
            default: rf_wd_sel = 0;
        endcase
    end
    // [alu_src1_sel] ALU operator 1 source (0 for register file, 1 for current pc)
    // arith, addi, shift, shift_i, lui, jalr, lw, sw from register; beq, blt, auipc, jal from pc
    assign alu_src1_sel = (opcode == BR || opcode == AUIPC || opcode == JAL);
    // [alu_src2_sel] ALU operator 2 source (0 for register file, 1 for sext immediate)
    // arith
    assign alu_src2_sel = ~(opcode == ARITH);
    // 在读寄存器 rs 为 x0 时, 将 rf_re 设置为 0
    assign rf_re0 = ~alu_src1_sel && |inst[19:15];
    assign rf_re1 = ~alu_src2_sel && |inst[24:20];
    // [alu_func] Operating mode: add / pass2 / other
    always @(*) begin
        if (opcode == LUI)
            alu_func = 4'b1010; // Pass op2
        else if (opcode == ARITH || opcode == ARITHI)
             case (inst[14:12])
                3'b000: alu_func = (opcode == ARITHI) ? 4'b0000 : (inst[30] ? 4'b0001 : 4'b0000); // Sub/Add
                3'b001: alu_func = 4'b1001; // Sll(i)
                3'b010: alu_func = 4'b0100; // Slt(i)
                3'b011: alu_func = 4'b0011; // Slt(i)u
                3'b100: alu_func = 4'b0111; // Xor(i)
                3'b101: alu_func = (inst[30]) ? 4'b1011 : 4'b1000; // Sra(i)/Srl(i)
                3'b110: alu_func = 4'b0110; // Or(i)
                3'b111: alu_func = 4'b0101; // And(i)
                default: alu_func = 4'b0000; // Add
             endcase
        else if (opcode == TRAP) begin
            alu_func = ebreak ? 4'b0000 : 4'b1111; // csrrs: return value of CSR (Does not support modify)
        end else
            alu_func = 4'b0000; // Add
    end
    // [imm_type] Completed at `Immediate.v`
    assign imm_type = 0;
    // [mem_we]
    assign mem_we = (opcode == STORE);
    // [load_type]
    always @(*) begin
        if (opcode == LOAD) begin
            case (inst[13:12])
                2'b00: load_type = {1'b1, inst[21:20]};
                2'b01: load_type = {2'b01, inst[21]};
                2'b10: load_type = 3'b000;
                default: load_type = 0;
            endcase
        end else load_type = 0;
    end
    // [load_sext] Only if inst is load type and not lw and inst[14]=0
    assign load_sext = (opcode == LOAD && ~inst[13]) ? ~inst[14] : 0;
    // [store_type]
    always @(*) begin
        if (opcode == STORE) begin
            case (inst[13:12])
                2'b00: store_type = {1'b1, inst[8:7]};
                2'b01: store_type = {2'b01, inst[8]};
                2'b10: store_type = 3'b000;
                default: store_type = 0;
            endcase
        end else store_type = 0;
    end
endmodule