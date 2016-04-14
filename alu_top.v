module alu_top #(
	parameter width = 6
)(
	input						clk,
	input  [width-1:0] 	a,
	input  [width-1:0] 	b,
	input  [1:0] 			func,
	output [2*width-1:0] out,
	output 					ovf
);
	
	wire add_out, sub_out, mul_out, div_out;
	wire add_ovf, sub_ovf, mul_ovf, div_ovf;
	
	add_top add(
		.a			 (a),
		.b			 (b),
		.out		 (add_out),
		.overflow (add_ovf)
	);
	
	sub_top sub(
		.a			 (a),
		.b 		 (b),
		.out		 (sub_out),
		.overflow (sub_ovf)
	);

	assign out = (func == 2'b00) ? add_out : 
					 (func == 2'b01) ? sub_out : 2'bzz;
	assign overflow = add_ovf | sub_ovf;
	
endmodule
