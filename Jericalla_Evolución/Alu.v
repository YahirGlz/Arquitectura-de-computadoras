module AND(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A&B;
endmodule

module OR(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A|B;
endmodule

module ADD(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A+B;
endmodule

module SUBS(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A-B;
endmodule

module SOLT(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = A<B?1:0;
endmodule

module NOR(input [31:0]A, input [31:0]B, output reg [31:0]R);
  assign R = ~(A|B);
endmodule

module ALU(input [31:0]X, input [31:0]Y, input [3:0]S, output reg [31:0]r);
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
  end
endmodule
