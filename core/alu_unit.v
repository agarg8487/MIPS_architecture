module alu_unit(output [31:0] alu_out,// 32 bit output
                output carry_out, // carry out flag
                output zero_flag,

                input [2:0]alu_op, // alu selection
                input [31:0] A,B //alu inputs
);
reg [31:0] alu_result;
wire [32:0] temp;
wire [32:0] temp_b;
assign temp_b= (alu_op[2])?(B^32'hffffffff):(B);
assign temp = A + temp_b;
assign carry_out = temp[32]; //carry flag
always@(*)
 begin
    case(alu_op[1:0])
     2'b10: alu_result=temp[31:0];
     2'b00: alu_result = A&B ;
     2'b01: alu_result = A|B;
     2'b11: alu_result= 32'hffffffff; // slt
     default: alu_result = 32'hffffffff;
    endcase
 end

assign zero_flag = (alu_result == 0) ? 1'b1 : 1'b0;
assign alu_out=alu_result; // alu output
endmodule