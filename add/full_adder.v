module full_adder(
	input		a,
	input		b,
	input		c_in,
	output	sum,
	output	c_out
);
	
	wire ha1_c, ha1_s, ha2_c;
	
	half_adder ha1(
		.a			(a),
		.b			(b),
		.sum		(ha1_s),
		.carry	(ha1_c)
	);
	half_adder ha2(
		.a			(c_in),
		.b			(ha1_s),
		.sum		(sum),
		.carry	(ha2_c)
	);
	or g1(c_out, ha1_c, ha2_c); 

endmodule
