`timescale 1ns/1ns
module ROM(input [3:0]addressA, 
		   input [3:0]addressB, 
		   output reg [31:0]dataA, 
		   output reg [31:0]dataB);
  reg [31:0]memory[15:0];
  always @(*) begin
      dataA = memory[addressA]; end 
      dataB = memory[addressB]; end
  end
endmodule
/////////////////////////////////////////////////////////
/*
module ROM_TB();
  reg  [ 3:0]addressA_TB, addressB_TB;
  wire [31:0]dataA_TB, dataB_TB;
  readMemory m(.addressA(addressA_TB), 
		       .addressB(addressB_TB),  
		       .dataA(dataA_TB),
		       .dataA(dataA_TB));
  initial begin
    #100;
	$readmemb("data.txt", ROM.memory);
  end
endmodule
*/
