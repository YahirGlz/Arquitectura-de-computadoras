module And(input [31:0]A, input [31:0]B, output reg [31:0]R);
  always @(*) begin
    R = A & B;
  end
endmodule

module Or(input [31:0]A, input [31:0]B, output reg [31:0]R);
    always @(*) begin
    R = A | B;
  end
endmodule

module Add(input [31:0]A, input [31:0]B, output reg [31:0]R);
    always @(*) begin
    R = A + B;
  end
endmodule

module Sub(input [31:0]A, input [31:0]B, output reg [31:0]R);
  always @(*) begin
    R = A - B;
  end
endmodule

module Slt(input [31:0]A, input [31:0]B, output reg [31:0]R);
  always @(*) begin
    R = A<B?1:0;
  end
endmodule

module Nor(input [31:0]A, input [31:0]B, output reg [31:0]R);
  always @(*) begin
    R = ~(A|B);
  end
endmodule

module Alu(input [31:0]X, input [31:0]Y, input [3:0]op, output reg [31:0]r, output reg zero);
  initial begin
    zero = 0;
    r = 0;
  end
  wire [31:0]w[5:0];
  And  And_(.A(X), .B(Y), .R(w[0]));
  Or   Or_ (.A(X), .B(Y), .R(w[1]));
  Add  Add_(.A(X), .B(Y), .R(w[2]));
  Sub  Sub_(.A(X), .B(Y), .R(w[3]));
  Slt  Slt_(.A(X), .B(Y), .R(w[4]));
  Nor  Nor_(.A(X), .B(Y), .R(w[5]));
  always @(*) begin
    case (op)
    4'd0:  begin r = w[0]; end 
    4'd1:  begin r = w[1]; end 
    4'd15: begin r = w[2]; end 
    4'd6:  begin r = w[3]; end 
    4'd7:  begin r = w[4]; end  
    4'd12: begin r = w[5]; end  
    endcase
    zero = r==0 ? 1:0;
  end
endmodule
