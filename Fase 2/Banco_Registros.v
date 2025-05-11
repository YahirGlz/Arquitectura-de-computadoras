
module Banco_Registros(input [4:0]wa,
           	           input [4:0]ra_A, // Read Address 
	   	                 input [4:0]ra_B, 
	   	                 input [31:0]data_in,  
           	           input we,
                       output reg [31:0]dataA, 
	   	                 output reg [31:0]dataB);

  reg [31:0]memory[31:0];
  
  initial begin
    $readmemb("dataBR.txt", memory);
    dataA = 0;
    dataB = 0;   
  end    

  always @(*) begin
      dataA = memory[ra_A]; 
      dataB = memory[ra_B];
      if(we) begin
        memory[wa] = data_in;
      end        
  end

endmodule
