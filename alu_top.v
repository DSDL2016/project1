module alu_top #(
    parameter width = 6
)(
    input                    clk,
    input      [width-1:0]   a,
    input      [width-1:0]   b,
    input      [1:0]         func,
    output reg [2*width-1:0] out,
    output                   ovf
);

    // wires for module output
    wire add_out, sub_out, mul_out, div_out;
    // wires for overflow signals
    wire add_ovf, sub_ovf, mul_ovf, div_ovf;

    add_top add(
        .a   (a),
        .b   (b),
        .out (add_out),
        .ovf (add_ovf)
    );

    sub_top sub(
        .a   (a),
        .b   (b),
        .out (sub_out),
        .ovf (sub_ovf)
    );
	
    always @(*) begin
        case(func)
            2'b00: out = {{width{1'b0}}, add_out};
            2'b01: out = {{width{1'b0}}, sub_out};
            2'b10: out = mul_out;
            2'b11: out = div_out;
        endcase
    end		  
    assign overflow = add_ovf | sub_ovf;

endmodule
