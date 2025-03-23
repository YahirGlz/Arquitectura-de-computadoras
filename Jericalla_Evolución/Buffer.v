module buffer(input [31:0]in,
              input clk_b,
	            output reg [31:0]out);

  always @(posedge clk_b) begin
    out = in;
  end

endmodule