`ifndef RAM_SV
`define RAM_SV

module ram #(parameter WIDTH = 8,
             parameter DEPTH = 16,
             parameter DEPTH_BITS = $clog2(DEPTH))
(
    input logic clk,
    input logic write_en,
    input logic [DEPTH_BITS-1:0] write_addr,
    input logic [DEPTH_BITS-1:0] read_addr,
    input logic [WIDTH-1:0] data_in,
    output logic [WIDTH-1:0] data_out
);

    logic [DEPTH-1:0][WIDTH-1:0] mem;
    
    always_ff @(posedge clk) begin
        if (write_en) begin
            mem[write_addr] <= data_in;
        end
    end

    always_ff @(posedge clk) begin
        data_out <= mem[read_addr];
    end

endmodule

`endif
