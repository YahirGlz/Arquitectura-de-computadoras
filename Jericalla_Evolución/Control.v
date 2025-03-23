module control(input      [1:0]opCode,
	       output reg [7:0]controlBus);

  always @(opCode) begin
    case (opCode)
	  3'd0:  begin controlBus = 8'B 1_0010_0_0_0; end 
	  3'd1:  begin controlBus = 8'B 1_0110_0_0_0; end 
	  3'd2:  begin controlBus = 8'B 1_0111_0_0_0; end 
	  3'd3:  begin controlBus = 8'B 0_0000_1_1_0; end  
    endcase
  end

endmodule