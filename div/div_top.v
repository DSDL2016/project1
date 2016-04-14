module div_top #(
	parameter width = 6
)(
	input		  [width-1:0] a, b,
	output reg [width-1:0] q, r
);

   integer                    divided;
   integer                    highest_bit;
   integer                    i;
   
   
   always @( a, b )   
     begin         
        divided = a;
        q = 0;
        highest_bit = 0;        
        for( i = 0; i < width; ++i )
          begin
             if( b[i] )
               highest_bit = i;
          end
        
        for( i = width - 1; i >= highest_bit; --i )
          begin
             if( divided >= (b << (i - highest_bit)) )
               begin
                  divided = divided - (b << (i - highest_bit) );
                  q[i - highest_bit] = 1;
                  
               end
          end        
        r = divided;        
     end // always @ ( a, b )

	
endmodule
