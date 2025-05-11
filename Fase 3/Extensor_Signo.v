module Extensor_Signo #(parameter width_in = 16, parameter width_out = 32)
                       (input [width_in-1:0]in, output reg [width_out-1:0]out);
  initial begin out = 0; end
  always @(in) begin
    out = {{width_out-width_in{in[width_in-1]}}, in};
  end 
endmodule