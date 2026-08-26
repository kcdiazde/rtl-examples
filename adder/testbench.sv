module testbench;

parameter int SIZE = 8;
parameter int WAIT_TIME = 1 << (2*SIZE);

    logic [SIZE*2-1:0] counter;
    logic a;
    logic b;
    logic c;

    initial begin
       counter <= '0;
    end

    initial begin
        $display("[%0t] Starting...", $time);
        #WAIT_TIME
        $display("[%0t] Ending...", $time);
        $finish;
    end

    always begin
        #1 counter <= counter + 'b1;
        // $display("Half adder: a = [%0d] b = [%0d] result = [%0d]", a, b, result_tb_half);
        // $display("Full adder: a = [%0d] b = [%0d] c = [%0d] result = [%0d]", a, b, c, result_tb_full);
        $display("[%0d] + [%0d] = [%0d]", a_adder, b_adder, result_tb);
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
        #1 assert(result_real_full == result_tb_full) else $error("Diff result in full adder!");
    end
    /* Full Adder ************************************************************/

    /* Adder *****************************************************************/
    logic [SIZE-1:0] out;
    logic carry;
    logic [SIZE:0] result_real;
    logic [SIZE:0] result_tb;

    logic [SIZE-1:0] a_adder;
    logic [SIZE-1:0] b_adder;
    
    assign a_adder = counter[SIZE-1:0];
    assign b_adder = counter[SIZE*2-1:SIZE];
    assign result_real= a_adder + b_adder;
    assign result_tb = {carry, out};

    adder #(.SIZE(SIZE)) adder_tb (
         .a(a_adder),
         .b(b_adder),
         .out(out),
         .carry(carry)
    );

    always begin
        #1 assert(result_real == result_tb) else $error("Diff result in adder!");
    end
    /* Adder *****************************************************************/

endmodule
