module mux_2_top #(
	parameter width = 6
)(
	input [width-1:0]      a, b,
	input                  sel,
    output reg [width*2-1:0] out
);

   integer                 sum = 0;
   integer                 i = 0;
   
   always @( a, b )   
     begin         
        sum = 0;

        for( i = 0; i < width; ++i )
          begin
             if( b[i] )
               begin
                  sum = sum + (a << i);
               end
          end        
        out = sum;        
     end // always @ ( a, b )
   
endmodule
