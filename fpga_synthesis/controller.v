//author : Aditya Terkar, 16EC01003, IIT Bhubaneswar
//aim : mod-16 counter
//====================================project includes================================
//processor includes
`include "../core/instructions_defines.v"
`include "../core/register_file.v"
`include "../core/write_reg_mux.v"
`include "../core/alu_b_mux.v"
`include "../core/pc_mux.v"
`include "../core/write_data_mux.v"
`include "../core/alu_unit.v"
`include "../core/control_unit.v"


//instruction_memory and data memory
`include "../test_benches/data_mem_size.v"
`include "../test_benches/instruction_mem_rom.v"
`include "../test_benches/data_mem.v"

//seven segment led controller
`include "seg_led_driver.v"
//====================================================================================
module mod_controller (

		input reset,
		input clk,
		input show_mem_ptr,
		input incr_mem_ptr,
		input dcr_mem_ptr,
		input hex_or_dec,
		input upper_or_lower,

		output wire [3 : 0] anode,
		output wire [7 : 0] cathode,
		output reg completed,
		output reg not_completed 
	);

//-----------------------parameters---------------------------------
	//mips processor ports
	wire [31 : 0] wr_instruction;
	wire [31 : 0] wr_data;
	wire rg_divided_clk;
	wire ins_mem_end;
	reg [31 : 0] internal_reg;

	//instruction memory ports
	wire [31 : 0] wr_pc;

	//data memory ports
	wire [31 : 0] wr_data_address;
	wire [31 : 0] wr_write_data;
	wire wr_mem_read, wr_mem_write;
	reg [31 : 0] rg_mem_ptr;
	wire [31 : 0] wr_data_port2;


	//LED drivers
	reg [1 : 0] incr_flag;
	reg [1 : 0] dcr_flag;
	reg [3 : 0] rg_decimal_d0;
	reg [3 : 0] rg_decimal_d1;
	reg [3 : 0] rg_decimal_d2;
	reg [3 : 0] rg_decimal_d3;

	reg [3 : 0] rg_hex_d0;
	reg [3 : 0] rg_hex_d1;
	reg [3 : 0] rg_hex_d2;
	reg [3 : 0] rg_hex_d3;

	reg [3 : 0] rg_data_0;
	reg [3 : 0] rg_data_1;
	reg [3 : 0] rg_data_2;
	reg [3 : 0] rg_data_3;
//------------------------------------------------------------------
//------------------module instantiations---------------------------
	mod_mips_processor dut_1 (
		//input ports
		.instruction(wr_instruction),
		.data(wr_data),
		.clk(wr_divided_clk),
		.reset(reset),
		.hold(ins_mem_end),

		//output ports
		.rg_pc(wr_pc),
		.data_address(wr_data_address),
		.write_data(wr_write_data),
		.mem_read(wr_mem_read),
		.mem_write(wr_mem_write),
	);
	
	mod_instruction_mem_rom ins_mem ( 
		//input ports
		.address(wr_pc[31 : 2]]),
		
		//output ports
		.instruction(wr_instruction),
		.mem_end(ins_mem_end),

	);

	mod_data_mem data_mem ( 
		//input ports
		.data_address_1(wr_data_address),
		.write_data(wr_write_data),
		.mem_read(wr_mem_read),
		.mem_write(wr_mem_write),
		.data_address_2(rg_mem_ptr),
		.reset(reset),
		.clk(rg_divided_clk),

		//output ports
		.data_out_1(wr_data),
		.data_out_2(wr_data_port2),
	);

	mod_seg_led_driver driver(
		//input ports
		.clk(clk),
		.reset(reset),
		.data_0(rg_data_0),
		.data_1(rg_data_1),
		.data_2(rg_data_2),
		.data_3(rg_data_3),

		//output ports
		.anode(anode),
		.cathode(cathode)	
	);
//------------------------------------------------------------------
//----------------hardware action for mem ptr-----------------------

	//incr_flag logic and dcr_flag logic
	always @(posedge clk) begin
		if (reset) incr_flag <= 2'b00;
		else begin
			if ((incr_mem_ptr)) begin
			 	if (incr_flag == 2'b00) incr_flag <= 2'b01;
				else incr_flag <= 2'b11; 
			end else incr_flag <= 2'b00;
		end
	end
	
	always @(posedge clk) begin
		if (reset) dcr_flag <= 2'b00;
		else begin
			if ((dcr_mem_ptr)) begin
			 	if (dcr_flag == 2'b00) dcr_flag <= 2'b01;
				else dcr_flag <= 2'b11; 
			end else dcr_flag <= 2'b00;
		end
	end

	always @(posedge clk) begin
		if(reset) rg_mem_ptr <= 0;
		else begin 
			if (incr_flag == 2'b01) rg_mem_ptr <= rg_mem_ptr + 1; 
			else begin
				if (dcr_flag == 2'b01) rg_mem_ptr <= rg_mem_ptr - 1; 
			end
		end
	end
//------------------------------------------------------------------

//-------------hardware action for LED display----------------------

	//decimal data
	always @(posedge clk) begin
		rg_decimal_d0 <= (show_mem_ptr) ? 
		                    (rg_mem_ptr[14 : 0] / 1000) : 
							(wr_data_port2[14 : 0] / 1000);
	end
	always @(posedge clk) begin
		rg_decimal_d1 <= (show_mem_ptr) ?
							((rg_mem_ptr[14 : 0] % 1000) /100) :
							((wr_data_port2[14 : 0] % 1000) /100);
	end
	always @(posedge clk) begin
		rg_decimal_d2 <= (show_mem_ptr) ?
							(((rg_mem_ptr[14 : 0] % 1000) % 100) /10) :
							(((wr_data_port2[14 : 0] % 1000) % 100) /10);
	end
	always @(posedge clk) begin
		rg_decimal_d3 <= (show_mem_ptr) ?
							(((rg_mem_ptr[14 : 0] % 1000) % 100) % 10) :
							(((wr_data_port2[14 : 0] % 1000) % 100) % 10);
	end

	//hexadecimal data
	always @(posedge clk) begin
		rg_hex_d0 <= (show_mem_ptr) ?
						( (upper_or_lower) ? (rg_mem_ptr[19 : 16]) : (rg_mem_ptr[3 : 0]) ) :
						( (upper_or_lower) ? (upper_or_lower[19 : 16]) : (wr_data_port2[3 : 0]) ) ;
	end
	always @(posedge clk) begin
		rg_hex_d1 <= (show_mem_ptr) ?
						( (upper_or_lower) ? (rg_mem_ptr[23 : 20]) : (rg_mem_ptr[7 : 4]) ) :
						( (upper_or_lower) ? (upper_or_lower[23 : 20]) : (wr_data_port2[7 : 4]) ) ;
	end
	always @(posedge clk) begin
		rg_hex_d2 <= (show_mem_ptr) ?
						( (upper_or_lower) ? (rg_mem_ptr[27 : 24]) : (rg_mem_ptr[11 : 8]) ) :
						( (upper_or_lower) ? (upper_or_lower[27 : 24]) : (wr_data_port[11 : 8]) ) ;
	end
	always @(posedge clk) begin
		rg_hex_d3 <= (show_mem_ptr) ?
						( (upper_or_lower) ? (rg_mem_ptr[31 : 28]) : (rg_mem_ptr[15 : 12]) ) :
						( (upper_or_lower) ? (upper_or_lower[31 : 28]) : (wr_data_port2[15 : 12]) ) ;
	end


	//LED display
	always @(posedge clk) rg_data_0 <= (hex_or_dec) ? (rg_hex_d0) : (rg_decimal_d0);
	always @(posedge clk) rg_data_1 <= (hex_or_dec) ? (rg_hex_d1) : (rg_decimal_d1);
	always @(posedge clk) rg_data_2 <= (hex_or_dec) ? (rg_hex_d2) : (rg_decimal_d2);
	always @(posedge clk) rg_data_3 <= (hex_or_dec) ? (rg_hex_d3) : (rg_decimal_d3);
//------------------------------------------------------------------

//--------------hardware action for clock to processor--------------
	always @(posedge clk) begin
        if(reset) internal_reg <= 0;
        else if (internal_reg < 15000) internal_reg <= internal_reg + 1;
        else internal_reg <= 0;
    end
   
    always @(posedge clk) begin
        if (internal_reg < 7500) rg_divided_clk <= 1'b1;
        else rg_divided_clk <= 1'b0;
    end
   
   always @(posedge clk) begin
		completed <= ins_mem_end;
		not_completed <= ~ins_mem_end;
   end
endmodule
