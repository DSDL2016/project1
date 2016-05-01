module project1_top #(
    parameter width = 6,
	 parameter n_segs = 8
)(
    input      [width-1:0]    a,
    input      [width-1:0]    b,
    input      [2:0]          func,
    output     [2*width-1:0]  result,
    output     [0:7*n_segs-1] segs,
    output                    err
);

    wire               out_sel = func[2];
	 
	 // using these wires to route 7seg display
	 // ...starts from HEX0 to HEX7
	 reg [4*n_segs-1:0] w_bcd;
	 wire [0:7*n_segs-1] w_segs;

	 always @(*) begin
        if (out_sel) begin
		      // show a/b
				w_bcd = {w_bcd_b1, w_bcd_b10, w_bcd_bsgn, {4{1'b1}}, 
				         w_bcd_a1, w_bcd_a10, w_bcd_asgn, {4{1'b1}}};
		  end
		  else begin
		      // show c
				w_bcd = {w_bcd_c1, w_bcd_c10, w_bcd_c100, w_bcd_c1000,
				         w_bcd_csgn, {4{1'b1}}, {4{1'b1}}, {4{1'b1}}};
		  end
    end
	 
	 //
	 // alu
	 //
    alu_top alu(
        .a    (a),
        .b    (b),
        .func (func[1:0]),
        .out  (result),
        .ovf  (err)
    );
	 
	 //
	 // bin2bcd
	 //
	 wire [3:0] w_bcd_a1, w_bcd_a10, w_bcd_asgn;
	 wire [3:0] w_bcd_b1, w_bcd_b10, w_bcd_bsgn;
	 wire [3:0] w_bcd_c1, w_bcd_c10, w_bcd_c100, w_bcd_c1000, w_bcd_csgn;
	 bin2bcd conv_a(
	     .bin     (a),
		  .bcd     ({w_bcd_a10, w_bcd_a1}),
		  .bcd_sgn (w_bcd_asgn)
	 );
	 bin2bcd conv_b(
	     .bin     (b),
		  .bcd     ({w_bcd_b10, w_bcd_b1}),
		  .bcd_sgn (w_bcd_bsgn)
	 );
	 bin2bcd #(
		  .width  (2*width),
		  .digits (4)
	 ) conv_c (
	     .bin     (result),
		  .bcd     ({w_bcd_c1000, w_bcd_c100, w_bcd_c10, w_bcd_c1}),
		  .bcd_sgn (w_bcd_csgn)
	 );
	 
	 //
	 // bcd2seg
	 //
	 genvar i;
	 generate
	     for (i = 0; i < n_segs; i = i+1) begin : BCD2SEG_CONCAT
		      bcd2seg conv_seg(
				    .bcd (w_bcd[(n_segs-i)*4-1 -: 4]),
					 .seg (w_segs[i*7 +: 7])
				);
		  end
	 endgenerate
	 
	 assign segs = ~w_segs;
	 	 
endmodule
