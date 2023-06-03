module MEM_RECT(
    input [2:0] load_type,
    input load_sext,
    input [2:0] store_type,
    input [31:0] dm_din_mem, // To be rectified
    output reg [31:0] mem_din, // Rectified result
    input [31:0] mem_dout, // To be rectified
    output reg [31:0] dm_dout // Rectified result
);
    wire ext1 = load_sext && mem_dout[7];
    wire ext2 = load_sext && mem_dout[15];
    wire ext3 = load_sext && mem_dout[23];
    wire ext4 = load_sext && mem_dout[31];
    always @(*) begin
        case (store_type)
            3'b010: mem_din = {mem_dout[31:16], dm_din_mem[15:0]};
            3'b011: mem_din = {dm_din_mem[15:0], mem_dout[15:0]};
            3'b100: mem_din = {mem_dout[31:8], dm_din_mem[7:0]};
            3'b101: mem_din = {mem_dout[31:16], dm_din_mem[7:0], mem_dout[7:0]};
            3'b110: mem_din = {mem_dout[31:24], dm_din_mem[7:0], mem_dout[15:0]};
            3'b111: mem_din = {dm_din_mem[7:0], mem_dout[23:0]};
            default: mem_din = dm_din_mem;
        endcase
    end
    always @(*) begin
        case (load_type)
            3'b010: dm_dout = {{16{ext2}}, mem_dout[15:0]};
            3'b011: dm_dout = {{16{ext4}}, mem_dout[31:16]};
            3'b100: dm_dout = {{24{ext1}}, mem_dout[7:0]};
            3'b101: dm_dout = {{24{ext2}}, mem_dout[15:8]};
            3'b110: dm_dout = {{24{ext3}}, mem_dout[23:16]};
            3'b111: dm_dout = {{24{ext4}}, mem_dout[31:24]};
            default: dm_dout = mem_dout;
        endcase
    end
endmodule