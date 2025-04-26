module Buffer_Bajada(input [31:0]in,
                     input clk_b,
	                 output reg [31:0]out);
  initial begin out = 0; end
  always @(negedge clk_b) begin
    out = in;
  end

endmodule