module project1_top #(
    parameter width = 6
)(
    input      [width-1:0]   a,
    input      [width-1:0]   b,
    input      [2:0]         func,
    output reg [2*width-1:0] out,
    output     [0:6]         seg0, seg1, seg2, seg3, seg4, seg5, seg6, seg7,
    output                   err
);

    wire               out_sel = func[2];
    wire [2*width-1:0] result;
	 
	 // using these wires to route 7seg display
	 wire [6:0] w_seg0, w_seg1, w_seg2, w_seg3, w_seg4, w_seg5, w_seg6, w_seg7;
	 
	 always @(a or b or func) begin
        if (out_sel) begin
		      // show a/b
		      out = {a, b};
		  end
		  else begin
		      // show c
		      out = result;
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
	 bin2bcd conv_c #(
		  .width  (2*width),
		  .digits (4)
	 )(
	     .bin     (c),
		  .bcd     ({w_bcd_c1000, w_bcd_c100, w_bcd_c10, w_bcd_c1}),
		  .bcd_sgn (w_bcd_csgn)
	 );
	 
	 bin2bcd conv_b();
	 bin2bcd conv_c();
	 	 
endmodule
