module project1_top #(
    parameter width = 6,
	 parameter n_segs = 8
)(
    input      [width-1:0]    a,
    input      [width-1:0]    b,
    input      [2:0]          func,
    output reg [2*width-1:0]  out,
    output     [0:7*n_segs-1] segs,
    output                    err
);

    wire               out_sel = func[2];
    wire [2*width-1:0] result;
	 
	 // using these wires to route 7seg display
	 // ...starts from HEX0 to HEX7
	 wire [7*n_segs-1:0] w_segs;

	 always @(a or b or func) begin
        if (out_sel) begin
		      // show a/b
		      out = {a, b};
				w_segs = {w_bcd_b1, w_bcd_b10, w_bcd_bsgn, {7{1'b1}}, 
				          w_bcd_a1, w_bcd_a10, w_bcd_asgn, {7{1'b1}}};
		  end
		  else begin
		      // show c
		      out = result;
				w_segs = {w_bcd_c1, w_bcd_c10, w_bcd_c100, w_bcd_c1000,
				          w_bcd_csgn, {3*7{1'b1}}};
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
	     .bin     (c),
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
				    .bcd (w_segs[(n_segs-i)*7-1 -: 7]),
					 .seg (segs[i*7 +: 7])
				);
		  end
	 endgenerate
	 
	 	 
endmodule
