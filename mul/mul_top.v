module mul_top #(
    parameter width = 6
)(
    input      [width-1:0]   a, b,
    output reg [width*2-1:0] out,
    output done
);

   integer                 sum = 0;
   integer                 i = 0;
   integer                 sign = 1;
   integer                 i_a;
   integer                 i_b;
   integer                 mask = 31;
                
                reg r_done;
   
   initial begin
   r_done = 1;
   end
   
   always @( a or b)   
     begin       
     r_done = 0;
        sum = 0;
        i_a = a[width - 2: 0];           
        i_b = b[width - 2: 0];           
        sign = 1;        

        // extract the number part
        if( a[width - 1] )begin
           sign = -sign;
           i_a = (~i_a + 1) & mask;           
        end

        if( b[width - 1] )begin
           sign = -sign;
           i_b = (~i_b + 1) & mask;           
        end

        for(i = 0; i < width - 1; i = i+1)
          begin
             if( i_b[i] )
               begin
                  sum = sum + (i_a << i);
               end
          end        

        //$display( "raw sum = %b\n", sum );
        
        // remove overflow bit
        sum[2 * width - 1] = 0;
        
        // add back sign
        if( sign == -1 )begin
           sum = ~sum + 1;
        end

        out = sum;        
         r_done = 1;
         
     end // always @ ( a, b )
   
   assign done = r_done;
   
endmodule
