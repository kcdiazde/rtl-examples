module testbench;

    logic [1:0] counter;
    logic a;
    logic b;
    logic out;
    logic carry;
    logic [1:0] result_real;
    logic [1:0] result_tb;

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
        $display("a = [%0d] b = [%0d] out = [%0d] carry = [%0d]", a, b, out, carry);
    end

    assign a = counter[0];
    assign b = counter[1];
    assign result_real = a + b;
    assign result_tb = {carry, out};

    half_adder half_adder_tb (
         .a(a),
         .b(b),
         .out(out),
         .carry(carry)
    );

    always begin
        #1 assert(result_real == result_tb) else $error("Diff result!");
    end

endmodule
