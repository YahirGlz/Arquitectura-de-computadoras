module ALU(input [31:0]X, input [31:0]Y, input [3:0]S, output reg [31:0]r, output reg Zflag);
  wire [31:0]w[5:0];
  AND  _and (.A(X), .B(Y), .R(w[0]));
  OR   _or  (.A(X), .B(Y), .R(w[1]));
  ADD  _add (.A(X), .B(Y), .R(w[2]));
  SUBS _subs(.A(X), .B(Y), .R(w[3]));
  SOLT _solt(.A(X), .B(Y), .R(w[4]));
  NOR  _nor (.A(X), .B(Y), .R(w[5]));
  always @(*) begin
    case (S)
	  3'd0:  begin r = w[0]; end 
	  3'd1:  begin r = w[1]; end 
	  3'd2:  begin r = w[2]; end 
	  3'd6:  begin r = w[3]; end 
	  3'd7:  begin r = w[4]; end 
	  3'd12: begin r = w[5]; end  
	endcase
	if(r==0) Zflag = 1;
	else     Zflag = 0;
  end
endmodule
