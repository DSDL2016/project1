module project1_top #(
	parameter width = 6
)(
	input							clk,
	input		[width-1:0]		a,
	input		[width-1:0]		b,
	output	[2*width-1:0]	out,
	output						err
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
//	div_top div(
//	);
	
endmodule
