`timescale 1 ns/1 ns


module div_test_bench;

   localparam width = 6;
   localparam range  = 32; // This should be 2^{wdith}

   reg  [width-1:0] x, y;
   wire [width-1:0] r, q;
   
   div_top div(
               .a        (x), 
		       .b        (y), 
		       .q        (q), 
		       .r        (r)
               );

	integer x_cnt, y_cnt;
   integer  err = 0;
   
	initial begin 
		x = 8'b0;
		y = 8'b0;

		for (x_cnt = 0; x_cnt < range; x_cnt = x_cnt+1) begin
			x = x_cnt;
			for (y_cnt = 1; y_cnt < range; y_cnt = y_cnt+1) begin
               y = y_cnt;               
				#100
				if( q != x / y || r != x % y)
                  begin
				$display("FAILED:(%2d,%2d) x=%b, y=%b, q=%b, r=%b", x_cnt, y_cnt, x, y, q, r);
                     err = err + 1;                     
                  end
			end
		end

    $display("DIV unit test finished. Total %d errors.\n", err);
	end

endmodule
