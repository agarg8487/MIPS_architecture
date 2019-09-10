module write_reg_mux(input [4:0] ins_20_16,
                     input [4:0] ins_15_11,
                     input RegDest,
                     output wire [4:0] write_reg_add);
assign write_reg_add=(RegDest) ? ins_20_16:ins_15_11;
endmodule