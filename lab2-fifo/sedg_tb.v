module sedg_tb();
    reg clk = 0;
    initial begin
        forever begin
            #10 clk = ~clk;
        end
    end

    reg en;
    initial begin
        #35 en <= 1;
        #20 en <= 0;
        #100 en <= 1;
        #40 en <= 0;
        #100 $finish;
    end

    wire s, p;
    sedg sedg_inst(clk, en, s, p);
endmodule