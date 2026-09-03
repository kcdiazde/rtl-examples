`ifndef SERIALIZER_SV
`define SERIALIZER_SV

// MSB serializer
module serializer #(parameter SIZE = 8) (
    input logic clk,
    input logic rst_n,
    input logic enable,
    input logic [SIZE-1:0] in,
    output logic out
);

    parameter int COUNT_BITS = $clog2(SIZE);
    parameter int COUNTER_MAX = SIZE - 1;

    logic [COUNT_BITS-1:0] counter;
    logic shouldCount;

    assign shouldCount = enable && (counter != 0);

    always @(posedge clk) begin
        if (!rst_n) begin
            counter <= {COUNTER_MAX}[COUNT_BITS-1:0];
        end
        else begin
            if (shouldCount) begin
                counter <= counter - 1'b1;
            end
            else begin
                counter <= {COUNTER_MAX}[COUNT_BITS-1:0];
            end
        end
    end

    assign out = (enable) ? in[counter] : 'd0;

endmodule

`endif
