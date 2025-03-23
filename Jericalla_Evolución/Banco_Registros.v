
module banco_registros(input [4:0]WA,
           	           input [4:0]RA_A, // Read Address 
	   	                 input [4:0]RA_B, 
	   	                 input [31:0]dataIn,  
           	           input WE,
                       output reg [31:0]dataA, 
	   	                 output reg [31:0]dataB);

  reg [31:0]memory[31:0];
  
  initial begin
    $readmemb("dataBR.txt", memory);
  end    

  always @(*) begin
      dataA = memory[RA_A]; 
      dataB = memory[RA_B];
      if(WE) begin
        memory[WA] = dataIn;
      end        
  end

endmodule
