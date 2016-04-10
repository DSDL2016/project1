module neg_top #(
	parameter width = 6
)(
	input  [width-1:0] in,
	output [width-1:0] out
);

	genvar i;
	generate
		for(i = 0; i < width; i = i+1) begin : NEG_BLK
			not n(out[i], in[i]);
		end
	endgenerate
	
endmodule
