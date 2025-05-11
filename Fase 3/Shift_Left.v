module Shift_Left #(parameter width = 32)(input [width-1:0]in, 
                                          output reg [width-1:0]out);
  initial begin out = 0; end
  always @(in) begin
    out = in * 4;
  end
endmodule