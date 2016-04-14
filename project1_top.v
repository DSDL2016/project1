module project1_top #(
    parameter width = 6
)(
    input                    clk,
    input      [width-1:0]   a,
    input      [width-1:0]   b,
    input      [2:0]         func,
    output reg [2*width-1:0] out,
    output     [6:0]         seg_a_1, seg_a_10, seg_b_1, seg_b_10,
    output                   err
);

    wire out_sel = func[2];
    wire [2*width-1:0] result;

    alu_top alu(
        .clk  (clk),
        .a    (a),
        .b    (b),
        .func (func[1:0]),
        .out  (result),
        .ovf  (err)
    );
	 
	 seg_disp_top seg_a(
	     .clk   (clk),
		  .start (1'b1),
		  .bin   (a),
		  .bcd   ({seg_a_10, seg_a_1}),
		  .done  ()
	 );

    always @(a or b or func) begin
        if(out_sel) begin
		      // show a/b
		      out = {a, b};
				
		  end
		  else begin
		      // show c
		      out = result;
		  end
    end
	 
endmodule
