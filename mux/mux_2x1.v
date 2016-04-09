module mux_2x1(
	input		a,
	input		b,
	input		sel,
	output	out
);
	
	wire n_sel, sel1, sel2;
	
	not n1(n_sel, sel);
	
	and a1(sel1, a, n_sel);
	and a2(sel2, b, sel);
	or o1(out, sel1, sel2);
	
endmodule