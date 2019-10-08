module alu_unit(output [31:0] alu_out,// 32 bit output
                output carry_out, // carry out flag
                input [2:0]alu_op, // alu selection
                input [31:0] A,B //alu inputs
);
reg [31:0] alu_result;
wire [32:0] temp;
assign alu_out=alu_result; // alu out
assign temp ={1'b0,A} +{1'b0,B};
assign CarryOut = temp[32]; //carry flag
always@(*)
begin
    case(alu_op)
     3'b010: alu_result = A+B ;//add
     3'b110: alu_result = A-B ;//sub
     3'b000: alu_result = A&B ;//and
     3'b000: alu_result = A|B ;//or
     3'b111: alu_result = (A<B)?32'b1:32'b0 ;//slt
     3'b010: alu_result = A+B ;//lw
     3'b010: alu_result = A+B ;//sw
     3'b110: alu_result = A-B ;//beq
     default: alu_result = A+B;
    endcase
end