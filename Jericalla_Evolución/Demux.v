module demux(input [31:0]data_in,
	     input s,
	     output reg [31:0]alu,
	     output reg [31:0]memory);

  always @(*) begin

    if(s) begin
      alu = 32'b z;
      memory = data_in; 
    end
    else begin
      alu = data_in;
      memory = 32'b z;  
    end
      
  end

endmodule