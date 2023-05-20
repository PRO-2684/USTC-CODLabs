module ram_tb ();

    reg clk = 0;

    initial begin
        forever begin
            #10 clk = ~clk;
        end
    end

    reg [3:0] a = 0;
    reg [7:0] d = 0;
    reg we = 0;
    wire [7:0] spo;
    wire [7:0] douta;

    dist_mem_gen_0 dist_mem_inst (
        .a(a),      // input wire [3: 0] a
        .d(d),      // input wire [7 : 0] d
        .clk(clk),  // input wire clk
        .we(we),    // input wire we
        .spo(spo)   // output wire [7 : 0] spo
    );

    blk_mem_gen_0 blk_mem_inst (
        .clka(clk),    // input wire clka
        .wea(we),      // input wire wea
        .addra(a),  // input wire [3: 0] addra
        .dina(d),    // input wire [7 : 0] dina
        .douta(douta)   // output wire [7 : 0] douta
    );

    initial begin
        #15 a <= 1;
        #20 a <= 3;
        #20 d <= 114;
            we <= 1;
        #20 we <= 0;
        $finish;
    end

endmodule