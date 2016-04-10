`timescale 1 ns/1 ns


module mux_tb;

   localparam width = 6;
   localparam range  = 64; // This should be 2^{wdith}

   reg  [width-1:0] x, y;
   wire [width*2-1:0] out;
   wire             c_out;
   reg              sel;
   
   mux_2_top mux(
		         .a        (x), 
		         .b        (y), 
		         .sel      (sum), 
		         .out (out)
	             );

   integer          x_cnt, y_cnt;
   integer          err = 0;
   
   initial begin 
	  x = 8'b0;
	  y = 8'b0;
      
	  for(x_cnt = 0; x_cnt < range; x_cnt = x_cnt+1) begin
		 for(y_cnt = 0; y_cnt < range; y_cnt = y_cnt+1) begin
			#1000
				     $display("(%2d,%2d) x=%b, y=%b, out=%b", x_cnt, y_cnt, x, y, out);
			if( out != x * y)
              begin
			     $display(" FAILED");
                 err += 1;                 
              end
			$display("\n");
			
			y = y + 8'b1;
		 end
		 x = x + 8'b1;
	  end

	  $display("...finished %d errors\n", err);
   end

endmodule
