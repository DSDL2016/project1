module project1_top #(
	parameter width = 6
)(
	input							clk,
	input		[width-1:0]		a,
	input		[width-1:0]		b,
	output	[2*width-1:0]	c,
	output						err
);
	
	// TODO: wire err signal into OR gate
	add_top adder(
		.a				(a),
		.b				(b),
		.sum			(c),
		.overflow	(err)
	);

endmodule
