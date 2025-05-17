module Buffer_Bajada #(parameter width = 32) (input [width-1:0]in,
                                              input clk_b,
	                                            output reg [width-1:0]out);
  initial out = 0; 
  always @(negedge clk_b) out = in;
  
endmodule