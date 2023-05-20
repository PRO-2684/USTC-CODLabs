module ram_mode_tb();

    reg clk = 0;
    reg we = 0;
    reg [3:0] addr = 0;
    reg [7:0] din = 0;
    wire [7:0] dout_pr, dout_co, dout_prco;

    // Clock signal
    initial begin
        forever begin
            #10 clk = ~clk;
        end
    end

    // Write signal
    initial begin
        #43 we = 1;
            din = 8'h11;
        #20 din = 8'h22;
        #20 we = 0;
    end

    // Read address signal
    initial begin
        #25 addr = 4'ha;
        #20 addr = 4'hb;
        #20 addr = 4'hc;
        #20 addr = 4'hd;
        #100 $finish;
    end

    ram_wf_pr ram_wf_pr_inst (
        .clka(clk),    // input wire clka
        .wea(we),      // input wire wea
        .addra(addr),  // input wire [3 : 0] addra
        .dina(din),    // input wire [7 : 0] dina
        .douta(dout_pr)  // output wire [7 : 0] douta
    );

    ram_wf_co ram_wf_co_inst (
        .clka(clk),    // input wire clka
        .wea(we),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [3 : 0] addra
        .dina(din),    // input wire [7 : 0] dina
        .douta(dout_co)  // output wire [7 : 0] douta
    );

    ram_wf_prco ram_wf_prco_inst (
        .clka(clk),    // input wire clka
        .wea(we),      // input wire [0 : 0] wea
        .addra(addr),  // input wire [3 : 0] addra
        .dina(din),    // input wire [7 : 0] dina
        .douta(dout_prco)  // output wire [7 : 0] douta
    );

endmodule