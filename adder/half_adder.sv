`ifndef HALF_ADDER_SV
`define HALF_ADDER_SV

module half_adder (
    input logic a,
    input logic b,
    output logic out,
    output logic carry
);

    assign out = a ^ b;
    assign carry = a & b;

endmodule

`endif
