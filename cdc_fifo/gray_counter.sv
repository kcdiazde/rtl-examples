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

    // logic [WIDTH-1:0] gray_bits;

    always_ff @(posedge clk) begin
        if (rst_n) begin
            bin <= 'd0;
        end
        else begin
            if (inc) begin
                bin <= bin + 'b1;
            end
        end
    end

    assign gray[WIDTH-1] = bin[WIDTH-1];

    genvar i;
    generate for (i = WIDTH-2; i >= 0 ; i--) begin : gray_bit
        assign gray[i] = bin[i] ^ bin[i+1];
    end
    endgenerate

    // always_ff @(posedge clk) begin
    //     if (rst_n) begin
    //         gray <= 'd0;
    //     end
    //     else begin
    //         if (inc) begin
    //             gray <= gray_bits;
    //         end
    //     end
    // end


endmodule

`endif
