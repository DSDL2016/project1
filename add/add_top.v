module add_top #(
	parameter width = 6
)(
	input						c_in,
	input		[width-1:0]	a,
	input		[width-1:0]	b,
	output	[width-1:0]	out,
	output					ovf
);
	
	// additional bit of carry array is for overflow signal
	wire carry[width:0];
	
	// TODO: use carry look ahead instead of ripple
	genvar i;
	generate
		for(i = 0; i < width; i = i+1) begin : FA_CONCAT
			full_adder fa(
				.a		 (a[i]),
				.b		 (b[i]),
				.c_in	 (carry[i]),
				.sum	 (out[i]),
				.c_out (carry[i+1])
			);
		end
	endgenerate
	
	// c_in is 1'b0 for ADD
	assign carry[0] = c_in;
	assign ovf = carry[width];
	
endmodule
