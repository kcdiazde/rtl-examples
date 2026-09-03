module testbench;

parameter int SIZE = 8;

    logic [SIZE-1:0] in_tb;
    logic [SIZE-1:0] out_tb;
    logic clk;
    logic rst_n;
    logic enable_s;
    logic enable_d;
    logic serial_out;

    initial begin
        clk <= '0;
        in_tb <= 'haa;
        enable_s <= '0;
        enable_d <= '0;
        rst_n <= '1;
    end

    initial begin
       #1 rst_n <= 1'b0;
       #1 rst_n <= 1'b1;
       enable_s <= 1'b1;
       enable_d <= 1'b1;
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

    serializer #(.SIZE(SIZE)) serializer_tb (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable_s),
        .in(in_tb),
        .out(serial_out)
    );

    deserializer #(.SIZE(SIZE)) deserializer_tb (
        .clk(clk),
        .rst_n(rst_n),
        .enable(enable_d),
        .in(serial_out),
        .out(out_tb)
    );

    always begin
        #2 $display("Value in [%x] Value out [%x]", in_tb, out_tb);
    end
    

endmodule

