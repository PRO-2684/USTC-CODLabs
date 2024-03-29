`timescale 1ns / 1ps

/* 
 *   Author: YOU
 *   Last update: 2023.04.20
 */

module CPU(
    input clk, 
    input rst,

    // MEM And MMIO Data BUS
    output [31:0] im_addr,      // Instruction address (The same as current PC)
    input [31:0] im_dout,       // Instruction data (Current instruction)
    output [31:0] mem_addr,     // Memory read/write address
    output mem_we,              // Memory writing enable		            
    output [31:0] mem_din,      // Data ready to write to memory
    input [31:0] mem_dout,	    // Data read from memory

    // Debug BUS with PDU
    output [31:0] current_pc, 	        // Current_pc, pc_out
    output [31:0] next_pc,              // Next_pc, pc_in    
    input [31:0] cpu_check_addr,	    // Check current datapath state (code)
    output [31:0] cpu_check_data    // Current datapath state data
);
    
    // Write your CPU here!
    // You might need to write these modules:
    //      ALU、RF、Control、Add(Or just add-mode ALU)、And(Or just and-mode ALU)、PCReg、Imm、Branch、Mux、...
    wire [31:0] pc_next;
    wire [31:0] pc_cur;
    wire [31:0] pc_add4;
    wire [31:0] pc_jalr;
    wire [31:0] alu_res;
    wire [31:0] rd0;
    wire [31:0] rd1;
    wire [31:0] inst;
    wire [31:0] wb_data;
    wire [31:0] alu_op1;
    wire [31:0] alu_op2;
    wire [31:0] imm;
    wire [31:0] mem_rd;
    wire [3:0] alu_ctrl;
    wire [2:0] imm_type;
    wire [2:0] br_type;
    wire [1:0] wb_sel;
    wire br, jal, jalr, wb_en;
    wire alu_op1_sel, alu_op2_sel;

    // Input
    assign inst = im_dout;
    assign mem_rd = mem_dout;
    // Output
    assign im_addr = pc_cur;
    assign mem_addr = alu_res;
    assign mem_din = rd1;
    // Debug
    wire [31:0] rd_dbg;
    wire [31:0] check_data;
    assign current_pc = pc_cur;
    assign next_pc = pc_next;

    PC pc(.clk(clk), .rst(rst), .pc_next(pc_next), .pc_cur(pc_cur));
    ADD add_(.lhs(4),.rhs(pc_cur), .res(pc_add4));
    AND and_(.lhs(32'hfffffffe), .rhs(alu_res), .res(pc_jalr));
    Branch branch(.op1(rd0), .op2(rd1), .br_type(br_type), .br(br));
    NPC_sel npc_sel(.pc_add4(pc_add4), .pc_jal_br(alu_res), .pc_jalr(pc_jalr), .jal(jal), .jalr(jalr), .br(br), .pc_next(pc_next));
    RF rf(.clk(clk), .we(wb_en), .ra0(inst[19:15]), .ra1(inst[24:20]), .wa(inst[11:7]), .wd(wb_data), .ra_dbg(cpu_check_addr[4:0]), .rd0(rd0), .rd1(rd1), .rd_dbg(rd_dbg));
    MUX1 alu_sel1(.src0(rd0), .src1(pc_cur), .sel(alu_op1_sel), .res(alu_op1));
    MUX1 alu_sel2(.src0(rd1), .src1(imm), .sel(alu_op2_sel), .res(alu_op2));
    ALU alu(.alu_op1(alu_op1), .alu_op2(alu_op2), .alu_ctrl(alu_ctrl), .alu_res(alu_res));
    MUX2 reg_write_sel(.src0(alu_res), .src1(pc_add4), .src2(mem_rd), .src3(imm), .sel(wb_sel), .res(wb_data));
    CTRL ctrl(.inst(inst), .jal(jal), .jalr(jalr), .br_type(br_type), .wb_en(wb_en), .wb_sel(wb_sel), .alu_op1_sel(alu_op1_sel), .alu_op2_sel(alu_op2_sel), .alu_ctrl(alu_ctrl), .imm_type(imm_type), .mem_we(mem_we));
    Immediate immediate(.inst(inst), .imm_type(imm_type), .imm(imm));

    // Debug
    MUX1 cpu_check_data_sel(.src0(check_data), .src1(rd_dbg), .sel(cpu_check_addr[12]), .res(cpu_check_data));
    CHECK_DATA_SEL check_data_sel_inst (
        .pc_in       (pc_next),
        .pc_out      (pc_cur),
        .instruction (inst),
        .rf_ra0      (inst[19:15]),
        .rf_ra1      (inst[24:20]),
        .rf_rd0      (rd0),
        .rf_rd1      (rd1),
        .rf_wa       (inst[11:7]),
        .rf_wd       (wb_data),
        .rf_we       (wb_en),
        .imm         (imm),
        .alu_sr1     (alu_op1),
        .alu_sr2     (alu_op2),
        .alu_func    (alu_ctrl),
        .alu_ans     (alu_res),
        .pc_jalr     (pc_jalr),
        .dm_addr     (alu_res),
        .dm_din      (mem_din),
        .dm_dout     (mem_rd),
        .dm_we       (mem_we),
        .check_addr  (cpu_check_addr),
        .check_data  (check_data)
    );
endmodule