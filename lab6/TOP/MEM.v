`timescale 1ns / 1ps

module MEM(
    input clk,

    // MEM Data BUS with CPU
	// IM port
    input [31:0] im_addr,
    output [31:0] im_dout,

	// DM port
    input  [31:0] dm_addr,
    input dm_we,
    input  [31:0] dm_din,
    output [31:0] dm_dout,

    // MEM Debug BUS
    input [31:0] mem_check_addr,
    output [31:0] mem_check_data
);

    inst_mem Ins_mem (
        .a(im_addr[10:2]),       // input wire [8 : 0] a
        .spo(im_dout)           // output wire [31 : 0] spo
    );

    data_mem Data_mem (
        .a(dm_addr[9:2]),       // input wire [7 : 0] a
        .d(dm_din),             // input wire [31 : 0] d
        // .dpra(mem_check_addr[9:2]),  // input wire [7 : 0] dpra
        .dpra(mem_check_addr[7:0]),  // input wire [7 : 0] dpra
        .clk(clk),              // input wire clk
        .we(dm_we),             // input wire we
        .spo(dm_dout),          // output wire [31 : 0] spo
        .dpo(mem_check_data)    // output wire [31 : 0] dpo
    );
endmodule