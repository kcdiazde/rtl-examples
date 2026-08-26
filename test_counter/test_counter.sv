module test_counter;

    reg clk;
    logic [3:0] counter;

    initial begin
       clk <= '0;
    end

    initial begin
       $display("[%0t] Starting...", $time);
       #50
       $display("[%0t] Ending...", $time);
       $finish;
    end

    always begin
       #1 clk <= ~clk;
    end

    always begin
       #1 counter <= counter + 1'b1;
       $display("counter = [%0d]", counter);
    end
endmodule
