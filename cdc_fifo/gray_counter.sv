`ifndef GRAY_COUNTER_SV
`define GRAY_COUNTER_SV

module gray_counter #(parameter WIDTH = 4)
(
    input logic clk,
    input logic rst_n,
    input logic inc,
    output logic [WIDTH-1:0] bin,
    output logic [WIDTH-1:0] gray
);

    logic [WIDTH-1:0] bin_next;
    logic [WIDTH-1:0] gray_comb;

    assign bin_next = (~rst_n) ? 'b0 : (~inc) ? bin : bin + 'b1;

    always_ff @(posedge clk) begin
        if (~rst_n) begin
            bin <= 'd0;
        end
        else begin
            if (inc) begin
                bin <= bin_next;
            end
        end
    end


    assign gray_comb[WIDTH-1] = bin_next[WIDTH-1];

    genvar i;
    generate for (i = WIDTH-2; i >= 0 ; i--) begin : gray_bit
        assign gray_comb[i] = bin_next[i] ^ bin_next[i+1];
    end
    endgenerate

    always_ff @(posedge clk) begin
        if (~rst_n) begin
            gray <= 'd0;
        end
        else begin
            gray <= gray_comb;
        end
    end


endmodule

`endif
