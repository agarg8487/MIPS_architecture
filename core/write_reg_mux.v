module mod_write_reg_mux(input [4:0] ins_20_16,
                     input [4:0] ins_15_11,
                     input reg_dst,
                     output wire [4:0] write_reg_add);
assign write_reg_add=(reg_dst) ? ins_15_11 : ins_20_16;

/*always@(reg_dst, ins_15_11,ins_20_16) begin
    $display("reg_dst : %b, ins_15_11 : %b, ins_20_16 %b", 
              reg_dst, ins_15_11, ins_20_16);
end*/
endmodule
