module Shift_Left #(parameter width = 32)(input [width-1:0]in, 
                                          output reg [width-1:0]out);
  initial out = 0; 
  always @(in) out = in * 4;
endmodule