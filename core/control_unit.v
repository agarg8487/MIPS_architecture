//`include "instruction_defines.v"

module mod_control_unit(    input[5:0] opcode,
                            input[5:0] funct,
                            input carry_flag,    
                            output reg reg_dst,
                            output reg jump,
                            output reg branch,
                            output reg mem_read,
                            output reg mem_to_reg,
                            output reg [2:0] alu_op,
                            output reg mem_write,
                            output reg alu_src,
                            output reg reg_write                     
   );  
 //reg [7+`alusize:0] control_out;
 //assign {reg_data,jump,branch,mem_read,mem_to_read,
 //       alu_op,mem_write,alu_src,reg_write} = control_unit;

 // alu_op was based on lec 08 , this is sent to ALU directly
 always @(*)  
  begin  
      case(opcode)   
      `r_opcode:begin   
                case(funct)
                `funct_add:begin
                                reg_dst =1'b1 ;  
                                jump =1'b0 ;  
                                branch =1'b0 ;
                                mem_read =1'b0 ;
                                mem_to_reg =1'b0 ;  
                                alu_op =3'b010 ;  
                                mem_write =1'b0 ;  
                                alu_src =1'b0 ;  
                                reg_write =1'b1 ;
                         end
                `funct_sub:begin
                                reg_dst =1'b1 ;  
                                jump =1'b0 ;  
                                branch =1'b0 ;
                                mem_read =1'b0 ;
                                mem_to_reg =1'b0 ;  
                                alu_op =3'b110 ;  
                                mem_write =1'b0 ;  
                                alu_src =1'b0 ;  
                                reg_write =1'b1 ;
                        
                         end    
                `funct_and:begin
                                reg_dst =1'b1 ;  
                                jump =1'b0 ;  
                                branch =1'b0 ;
                                mem_read =1'b0 ;
                                mem_to_reg =1'b0 ;  
                                alu_op =3'b000 ;  
                                mem_write =1'b0 ;  
                                alu_src =1'b0 ;  
                                reg_write =1'b1 ;
                         end 
                `funct_or :begin
                                reg_dst =1'b1 ;  
                                jump =1'b0 ;  
                                branch =1'b0 ;
                                mem_read =1'b0 ;
                                mem_to_reg =1'b0 ;  
                                alu_op =3'b001 ;  
                                mem_write =1'b0 ;  
                                alu_src =1'b0 ;  
                                reg_write =1'b1 ;
                         end 
                `funct_slt:begin
                                reg_dst =1'b1 ;  
                                jump =1'b0 ;  
                                branch =1'b0 ;
                                mem_read =1'b0 ;
                                mem_to_reg =1'b0 ;  
                                alu_op =3'b111 ;  
                                mem_write =1'b0 ;  
                                alu_src =1'b0 ;  
                                if (carry_flag == 1'b1) reg_write = 1'b1 ; // check the carry flag
                                else reg_write = 1'b0;
                         end
                default :begin
                                reg_dst =1'b0 ;  
                                jump =1'b0 ;  
                                branch =1'b0 ;
                                mem_read =1'b0 ;
                                mem_to_reg =1'b0 ;  
                                alu_op =3'b101 ;  
                                mem_write =1'b0 ;  
                                alu_src =1'b0 ;  
                                reg_write =1'b0 ;
                         end         
                endcase         
        end
        `addi_opcode:begin // i have doubt in this section
                                reg_dst =1'b0 ;  
                                jump =1'b0 ;  
                                branch =1'b0 ;
                                mem_read =1'b0 ;
                                mem_to_reg =1'b0 ;  
                                alu_op =3'b010 ;  
                                mem_write =1'b0 ;  
                                alu_src =1'b1 ;  
                                reg_write =1'b1 ;
        end
        `lw_opcode: begin 
                        reg_dst =1'b0 ;  
                        jump =1'b0 ;
                        branch =1'b0 ;
                        mem_read =1'b1 ;
                        mem_to_reg =1'b1 ;
                        alu_op =3'b010 ;
                        mem_write =1'b0 ; 
                        alu_src =1'b1 ;
                        reg_write =1'b1 ;
        end  
        `sw_opcode: begin 
                        reg_dst =1'b0 ;  //i gave 0, it was dont care
                        jump =1'b0 ;
                        branch =1'b0 ;
                        mem_read =1'b0 ;
                        mem_to_reg =1'b0 ; // i gave 0 
                        alu_op =3'b010 ;
                        mem_write =1'b1 ; 
                        alu_src =1'b1 ;
                        reg_write =1'b1 ;
        
        end         
        `beq_opcode: begin 
                        reg_dst =1'b0 ;  // i gave 0 again
                        jump =1'b0 ;
                        branch =1'b1 ;
                        mem_read =1'b0 ;
                        mem_to_reg =1'b0 ; // i gave 0 
                        alu_op =3'b110 ; // based on lec08
                        mem_write =1'b0 ; 
                        alu_src =1'b0 ;
                        reg_write =1'b0 ;
        
        end  
        `j_opcode: begin 
                        reg_dst =1'b0 ;  
                        jump =1'b1 ;
                        branch =1'b0 ;
                        mem_read =1'b0 ;
                        mem_to_reg =1'b0 ;
                        alu_op =3'b101 ;
                        mem_write =1'b0 ; 
                        alu_src =1'b0 ;
                        reg_write =1'b0 ;
        
        end

      default: begin  
                        reg_dst =1'b0 ;  
                        jump =1'b0 ;  
                        branch =1'b0 ;
                        mem_read =1'b0 ;
                        mem_to_reg =1'b0 ;  
                        alu_op =3'b101 ;  
                        mem_write =1'b0 ;  
                        alu_src =1'b0 ;  
                        reg_write =1'b0 ;
                  
                end  
      endcase    
 end  
 endmodule  