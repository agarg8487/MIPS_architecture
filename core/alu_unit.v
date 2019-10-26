module alu_unit(output [31:0] alu_out,// 32 bit output
                output carry_out, // carry out flag
                input [2:0]alu_op, // alu selection
                input [31:0] A,B //alu inputs
);
reg [31:0] alu_result;
wire [32:0] temp;
assign M= (alu_op[2])?32'b1:32'b0;
assign B=B^M;
assign temp = A+B;
assign carry_out = temp[32]; //carry flag
always@(*)
 begin
    case(alu_op[1:0])
     2'b10: alu_result=A+B;
     2'b00: alu_result = A&B ;
     2'b01: alu_result = A|B;
     2'b11: alu_result= 32'b1; // slt
     default: alu_result = A+B;
    endcase
 end
assign alu_out=alu_result; // alu ou
endmodule