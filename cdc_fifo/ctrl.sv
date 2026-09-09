`ifndef CTRL_SV
`define CTRL_SV

module ctrl #(parameter WIDTH = 4)
(
    input logic clk,
    input logic rst_n,
    input logic wr_en,
    input logic rd_en, 
    input logic [WIDTH-1:0] wr_addr_in, 
    input logic [WIDTH-1:0] rd_addr_in, 

    output logic wr_ready,
    output logic rd_ready
    output logic [WIDTH-1:0] wr_addr_out, 
    output logic [WIDTH-1:0] rd_addr_out, 
);
    
    logic [WIDTH-1:0] wrptr_sync_middle;
    logic [WIDTH-1:0] wrptr_sync;
    logic [WIDTH-1:0] rdptr_sync_middle;
    logic [WIDTH-1:0] rdptr_sync;

    // TODO: Review can write vs ready to write

    logic can_write;

    always_comb begin
        if (~rst_n) begin
            can_write = 'b0;
        end
        else begin
            if (wr_en && can_write) begin
                can_write = 'b1;
            end
            else begin
                can_write = 'b0;
            end
        end
    end

    always_ff begin : sync_wr
        if (~rst_n) begin
            wrptr_sync_middle <= 'b0;
            wrptr_sync <= 'b0;
        end
        else begin
            wrptr_sync_middle <= wr_addr_in;
            wrptr_sync <= wrptr_sync_middle;
        end
    end

    always_ff begin : sync_rd
        if (~rst_n) begin
            rdptr_sync_middle <= 'b0;
            rdptr_sync <= 'b0;
        end
        else begin
            rdptr_sync_middle <= rd_addr_in;
            rdptr_sync <= rdptr_sync_middle;
        end
    end

    assign wr_ready = (wrptr_sync != prev_wrptr);
    assign rd_ready = (wrptr_sync != rd_ptr;


endmodule

`endif
