module testbench;

    logic [2:0] counter;
    logic a;
    logic b;
    logic c;

    initial begin
       counter <= '0;
    end

    initial begin
        $display("[%0t] Starting...", $time);
        #10
        $display("[%0t] Ending...", $time);
        $finish;
    end

    always begin
        #1 counter <= counter + 'b1;
        $display("Half adder: a = [%0d] b = [%0d] result = [%0d]", a, b, result_tb_half);
        $display("Full adder: a = [%0d] b = [%0d] c = [%0d] result = [%0d]", a, b, c, result_tb_full);
    end

    assign a = counter[0];
    assign b = counter[1];
    assign c = counter[2];

    /* Half Adder ************************************************************/
    logic out_half;
    logic carry_half;
    logic [1:0] result_real_half;
    logic [1:0] result_tb_half;

    assign result_real_half = a + b;
    assign result_tb_half = {carry_half, out_half};

    half_adder half_adder_tb (
         .a(a),
         .b(b),
         .out(out_half),
         .carry(carry_half)
    );

    always begin
        #1 assert(result_real_half == result_tb_half) else $error("Diff result!");
    end
    /* Half Adder ************************************************************/
    /*************************************************************************/

    /* Full Adder ************************************************************/
    logic out_full;
    logic carry_full;
    logic [1:0] result_real_full;
    logic [1:0] result_tb_full;

    assign result_real_full = a + b + c;
    assign result_tb_full = {carry_full, out_full};

    full_adder full_adder_tb (
         .a(a),
         .b(b),
         .c(c),
         .out(out_full),
         .carry(carry_full)
    );

    always begin
        #1 assert(result_real_full == result_tb_full) else $error("Diff result!");
    end
    /* Full Adder ************************************************************/

endmodule
