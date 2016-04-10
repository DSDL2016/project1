module alu_top #(
	parameter width = 6
)(
	input						clk,
	input  [width-1:0] 	a,
	input  [width-1:0] 	b,
	input  [1:0] 			func,
	output [2*width-1:0] out,
	output 					overflow
);
	
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
	
	or out_or(overflow, add_ovf, sub_ovf, mul_ovf, div_ovf);
	
endmodule
