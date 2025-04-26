module Buffer_Subida(input [31:0]in,
                     input clk_b,
	                   output reg [31:0]out);
  initial begin out = 0; end
  always @(posedge clk_b) begin
    out = in;
  end

endmodule