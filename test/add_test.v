module add_test_bench();
  
  parameter WIDTH = 6;
  
  reg cin;
  reg [WIDTH-1:0] a, b;
  
  wire w_cin, overflow;
  wire [WIDTH-1:0] w_a, w_b, wout;
  assign w_cin = cin;
  assign w_a = a;
  assign w_b = b;

  add_top add(cin, a, b, wout, overflow);
  parameter LOWER = -(1 << WIDTH);
  parameter UPPER = (1 << WIDTH) - 1;
  integer num_a, num_b, ans;
  initial begin
    $display("%d %d",LOWER,UPPER);
    for (num_a = LOWER; num_a <= UPPER; num_a = num_a + 1) begin
      for (num_b = LOWER; num_b <= UPPER; num_b = num_b + 1) begin
        a = num_a[WIDTH-1:0];
        b = num_b[WIDTH-1:0];
        $display("%d + %d", a, b);
        $display("%d", wout);
      end
    end
  end
endmodule

