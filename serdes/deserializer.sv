`ifndef DESERIALIZER_SV
`define DESERIALIZER_SV

// MSB Deserializer
module deserializer #(parameter SIZE = 8) (
    input logic clk,
    input logic rst_n,
    input logic enable,
    input logic in,
    output logic [SIZE-1:0] out
);

    always @(posedge clk) begin
        if (!rst_n) begin
            out <= '0;
        end
        else begin
            if (enable) begin
                out <= (out << 1) | {7'h0, in};
            end
        end
    end

endmodule

`endif
