module Extensor_Signo(input [15:0]in, output reg [31:0]out);
  initial begin out = 0; end
  always @(in) begin
    out = {{16{in[15]}}, in};
  end 
endmodule