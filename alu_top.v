module alu_top #(
    parameter width = 6
)(
    input      [width-1:0]   a,
    input      [width-1:0]   b,
    input      [1:0]         func,
    output reg [2*width-1:0] out,
    output reg               ovf
);

    // wires for module output
    wire [width-1:0]   add_out, sub_out;
	 wire [2*width-1:0] mul_out, div_out;
    // wires for overflow signals
    wire add_ovf, sub_ovf;

    add_top add(
        .c_in (1'b0),
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
	 
	 mul_top mul(
        .a    (a),
		  .b    (b),
		  .out  (mul_out)
	 );
	 
	 div_top div(
	     .a     (a),
		  .b     (b),
		  .q     (div_out[2*width-1:width]),
		  .r     (div_out[width-1:0])
	 );
	
    always @(a or b or func or add_out or sub_out or mul_out or div_out or add_ovf or sub_ovf) begin
        case(func)
            2'b00: ovf <= add_ovf; 
            2'b01: ovf <= sub_ovf;
            2'b10, 2'b11: ovf <= 0;
        endcase
        case(func)
            2'b00: out <= {{width{1'b0}}, add_out};
            2'b01: out <= {{width{1'b0}}, sub_out};
            2'b10: out <= mul_out;
            2'b11: out <= div_out;
        endcase
    end		  

endmodule
