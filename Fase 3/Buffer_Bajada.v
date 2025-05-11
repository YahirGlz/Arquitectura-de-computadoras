module Buffer_Bajada #(parameter width = 32) (input [width-1:0]in,
                                              input clk_b,
	                                            output reg [width-1:0]out);
  initial begin out = 0; end
  always @(negedge clk_b) begin
    out = in;
  end

endmodule