module mul #(
	parameter width = 6
)(
	input [width-1:0]      a, b,
	input                  sel,
    output reg [width*2-1:0] out
);

   integer                 sum = 0;
   integer                 i = 0;
   integer                 sign = 1;
   integer                 i_b;
   
   
   always @( a, b )   
     begin         
        sum = 0;
        
        // deal with sign
        if( b[width - 1] )begin
           sign = -1;
           i_b = ~b + 1;
        end
        else begin
          i_b = b;           
        end
        
        for( i = 0; i < width - 1; ++i )
          begin
             if( i_b[i] )
               begin
                  sum = sum + (a << i);
               end
          end        

        // deal with sign
        if( sign == -1 )begin
           out = ~out + 1;
        end
                 
     end // always @ ( a, b )
   
endmodule
