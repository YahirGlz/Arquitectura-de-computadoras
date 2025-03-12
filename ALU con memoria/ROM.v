
module ROM(input [3:0]addressA, 
	   input [3:0]addressB, 
	   output reg [31:0]dataA, 
	   output reg [31:0]dataB);
  reg [31:0]memory[15:0];
  always @(*) begin
      $readmemb("data.txt", memory);
      dataA = memory[addressA]; 
      dataB = memory[addressB]; 
  end
endmodule
