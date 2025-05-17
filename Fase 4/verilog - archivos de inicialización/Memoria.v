
module Memory(input [31:0]address, 
              input [31:0]data_in, // ... 4 bytes
              input       RW, // Read/Write 
	            output reg [31:0]data_out);

  reg [31:0]memory[127:0];

  initial begin 
    $readmemb("dataMe.txt", memory); 
    data_out = 32'bz;
  end  

  always @(*) begin
    if(RW)  memory[address] = data_in;   
    else    data_out = memory[address]; 
  end

endmodule
