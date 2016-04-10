module sub_top #(
	parameter width = 6
)(
	input	 [width-1:0] a,
	input  [width-1:0] b,
	output [width-1:0] out,
	output				 overflow
);
	
	// SUB = ADD and NEG

	add_top add(
		.c_in		 (1'b1),
		.a			 (a),
		.b			 (!b),
		.out		 (out),
		.overflow (overflow)
	);

endmodule
