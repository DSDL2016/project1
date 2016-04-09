module add_top #(
	parameter width = 6
)(
	input		[width-1:0]	a,
	input		[width-1:0]	b,
	output	[width-1:0]	sum,
	output					overflow
);
	
	// additional bit of carry array is for overflow signal
	wire carry[width:0];
	
	// TODO: use carry look ahead instead of ripple
	genvar i;
	generate
		for(i = 0; i < width; i = i+1) begin : FA_CONCAT
			full_adder fa(
				.a			(a[i]),
				.b			(b[i]),
				.c_in		(carry[i]),
				.sum		(sum[i]),
				.c_out	(carry[i+1])
			);
		end
	endgenerate
	
	// first bit is never 1'b1
	assign carry[0] = 1'b0;
	assign overflow = carry[width];
	
endmodule
