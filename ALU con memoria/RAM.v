
module RAM(input  [3:0]address, 
           input [31:0]dataIn,
           input       RW, 
	   output reg [31:0]dataOut);
  reg [31:0]memory[15:0];
  always @(*) begin
    if(RW) begin memory[address] = dataIn;  end 
    else   begin dataOut = memory[address]; end
  end
endmodule
