module lcu_tb ();
    reg clk = 1;
    reg rst = 0;
    reg [3:0] in = 0;
    reg enq = 0;
    reg deq = 0;
    wire [3:0] rd0;
    wire [3:0] out;
    wire full;
    wire empty;
    wire [2:0] ra0;
    wire [2:0] wa;
    wire [3:0] wd;
    wire we;
    wire [7:0] valid;

    lcu lcu_inst(clk, rst, in, enq, deq, rd0, wa, out, full, empty, ra0, wd, we, valid);

    register_file reg_inst(.clk(clk), .ra0(ra0), .rd0(rd0), .wa(wa), .we(we), .wd(wd));

    initial begin
        forever begin
            #10 clk = ~clk;
        end
    end

    initial begin
        repeat (2) begin
                in <= 6;    // 0
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 9;    // 09
            #20 enq <= 1;
            #100 enq <= 0;
            #20 deq <= 1;   // x9 -> out 0
            #60 deq <= 0;
                in <= 7;    // x97
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 5;    // x975
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 3;    // x9753
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 4;    // x97534
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 4'ha; // x97534a
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 3;    // x97534a3
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 2;    // 097534a3 full
            #20 enq <= 1;
            #100 enq <= 0;
                in <= 4'hb; // 097534a3 full
            #20 enq <= 1;
            #100 enq <= 0;
            #20 deq <= 1;   // 0x7534a3 -> out 9
            #60 deq <= 0;
            #20 deq <= 1;   // 0xx534a3 -> out 7
            #60 deq <= 0;
            #80 rst <= 1;
            #40 rst <= 0;
            #80 ;
        end
        $finish;
    end

endmodule