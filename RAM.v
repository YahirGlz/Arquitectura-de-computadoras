`timescale 1ns/1ns
module RAM(input  [3:0]address, 
		   input [31:0]dataIn,
		   input       RW, 
		   output reg [31:0]dataOut);
  reg [31:0]memory[15:0];
  always @(*) begin
    if(RW) begin memory[address] = dataIn; end 
    else begin   dataOut = memory[address]; end
  end
endmodule
/////////////////////////////////////////////////////////
/*
module RAM_TB();
  reg  [3:0]address_TB;
  reg [31:0]dataIn_TB;
  reg RW_TB;
  wire dataOut_TB;
  RAM_TB m(.address(address_TB),   
		   .dataIn(dataIn_TB),
		   .RW(RW_TB)
		   .dataOut(dataOut_TB));
  initial begin
    //#100;
	//$readmemb("data.txt", RAM.memory);
  end
endmodule
*/
