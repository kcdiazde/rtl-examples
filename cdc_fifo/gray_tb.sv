module testbench;

// parameter int SIZE = 8;

    // logic [SIZE-1:0] counter;
    logic clk;
    logic rst_n;
    logic inc;
    logic [3:0] gray;
    logic [3:0] bin;

    initial begin
       clk <= '0;
       rst_n <= '1;
       inc <= '0;
       #2 rst_n <= '0;
       #2 rst_n <= '1;
       #6 inc <= '1;
       #18 inc <= '0;
       #4 inc <= '1;
    end

    initial begin
        $display("[%0t] Starting...", $time);
        #100
        $display("[%0t] Ending...", $time);
        $finish;
    end

    always begin
        #1 clk <= ~clk;
    end

    gray_counter gray_counter_tb (
        .clk(clk),
        .rst_n(rst_n),
        .inc(inc),
        .gray(gray),
        .bin(bin)
    );

    always begin
        #2 $display("[%0t][En=%0d] - Bin [%0b] Gray [%0b]", $time, inc, bin, gray);
    end


endmodule
