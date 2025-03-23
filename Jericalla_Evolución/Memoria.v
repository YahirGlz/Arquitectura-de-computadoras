
module memory(input  [6:0]address, //128 localidades de...
              input [31:0]dataIn, // ... 4 bytes
              input       W,
              input       R, 
	      output reg [31:0]dataOut);

  reg [31:0]memory[127:0];

  initial begin
    $readmemb("dataMe.txt", memory);
  end  

  always @(*) begin
    dataOut = 1;
    if(W) begin memory[address] = dataIn;  end 
  end

endmodule
