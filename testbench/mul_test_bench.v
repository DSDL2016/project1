`timescale 1 ns/1 ns


module mul_test_bench;

   localparam width = 6;
   localparam range  = 32; // This should be 2^{wdith - 1}

   reg  [width-1:0] x, y;
   reg signed [width*2-1:0] reg_out;
   wire [width*2-1:0] out;
   wire             c_out;
   
   mul_top mul(
		         .a        (x), 
		         .b        (y), 
		         .out (out)
	             );

   integer          x_cnt, y_cnt;
   integer          err = 0;
   
   initial begin 
      
	  for(x_cnt = -range + 1; x_cnt < range; x_cnt = x_cnt+1) begin
		 for(y_cnt = -range + 1; y_cnt < range; y_cnt = y_cnt+1) begin
            x[width - 2: 0] = x_cnt[width - 2: 0];
            y[width - 2: 0] = y_cnt[width - 2: 0];
            x[width - 1] = (x_cnt < 0)? 1: 0;
            y[width - 1] = (y_cnt < 0)? 1: 0;
            
			#100
			     reg_out = out;
				   //$display("------out = %b %d", out, reg_out);
			if( out != ((x_cnt * y_cnt) & 4095))
              begin
			     //$display(" FAILED");
			  $display("(%2d,%2d) x=%b, y=%b, out=%b, ans=%b", x_cnt, y_cnt, x, y, out, (x_cnt * y_cnt) & 4095 );
                 err = err + 1;                 
              end
			//$display("\n");
		 end
	  end

	  $display("...finished %d errors\n", err);
   end

endmodule
