module project1_top #(
	parameter width = 6
)(
	input	   				clk,
	input	 [width-1:0]	a,
	input	 [width-1:0]	b,
	output [2*width-1:0]	out,
	output [6:0]			seg_a_1, seg_a_10, seg_b_1, seg_b_10,
	output					err
);
	
	// TODO: wire err signal into OR gate
	add_top add(
		.a				(a),
		.b				(b),
		.sum			(out),
		.overflow	(err)
	);
	
//	sub_top sub(
//		.a				(a),
//		.b				(b),
//		.rem			(out),
//		.overflow	(err)
//	);
//	
//	mul_top mul(
//	);
//	
	div_top div(
		.clk			(clk),
		.sign			(1'b0),
		.a				(a),
		.b				(b),
		.q				(),
		.r				(),
		.ready		()
	);
	
endmodule
