`ifndef ADDER_SV
`define ADDER_SV

module adder #(parameter SIZE = 8) (
    input logic [SIZE-1:0] a,
    input logic [SIZE-1:0] b,
    output logic [SIZE-1:0] out,
    output logic carry
);

    logic [SIZE-1:0] partial_carry;

    full_adder full_adder_0 (
        .a(a[0]),
        .b(b[0]),
        .c('0),
        .out(out[0]),
        .carry(partial_carry[0]) 
    );

    genvar i;
    generate for (i = 1; i < SIZE; i++) begin : adder_inst
        
        full_adder full_adder_0 (
            .a(a[i]),
            .b(b[i]),
            .c(partial_carry[i-1]),
            .out(out[i]),
            .carry(partial_carry[i]) 
        );

    end
    endgenerate

    assign carry = partial_carry[SIZE-1];

endmodule

`endif
