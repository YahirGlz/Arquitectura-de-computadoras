module Shift_Left(input [31:0]in, output reg [31:0]out);
  initial begin out = 0; end
  always @(in) begin
    out = in * 4;
  end
endmodule