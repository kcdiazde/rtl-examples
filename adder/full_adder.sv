`ifndef FULL_ADDER_SV
`define FULL_ADDER_SV

module full_adder (
    input logic a,
    input logic b,
    input logic c,
    output logic out,
    output logic carry
);

    logic partial_out;
    logic partial_carry_1;
    logic partial_carry_2;

    half_adder half_adder_1 (
        .a(a),
        .b(b),
        .out(partial_out),
        .carry(partial_carry_1) 
    );

    half_adder half_adder_2 (
        .a(partial_out),
        .b(c),
        .out(out),
        .carry(partial_carry_2) 
    );

    assign carry = partial_carry_1 ^ partial_carry_2;

endmodule

`endif
