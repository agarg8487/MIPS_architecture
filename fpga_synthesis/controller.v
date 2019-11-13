//author : Aditya Terkar, 16EC01003, IIT Bhubaneswar
//aim : mod-16 counter

`include "counter.v"
`include "clock_divider.v"
`include "seven_segment_driver.v"

module mod_controller (

						//input ports
						input clk,
						input reset,
						input run,

						//output ports
						output wire [3 : 0] wr_anode,
						output wire [8 : 0] wr_cathode
					);

//-----------------------parameters---------------------------------
	wire wr_clk_counter;
	wire wr_clk_seven_segment;
	
	wire [3 : 0] wr_count;
//------------------------------------------------------------------
//------------------module instantiations---------------------------
	mod_clock_divider #(32,80,80) clk_to_count (
		
		//input ports
		.clk(clk), 
		.reset(reset),

		//output ports
		.div_clk(wr_clk_counter)
	);

	mod_clock_divider #(32,80,80) clk_to_seven_segment (
	
		//input ports
		.clk(clk), 
		.reset(reset),

		//output ports
		.div_clk(wr_clk_seven_segment)
	);

	mod_counter_16 counter (
		
		//input ports
		.clk(wr_clk_counter),
		.run(run),
		.reset(reset),
		
		//output ports
		.rg_count(wr_count)
	);
	
	mod_seven_segment_driver (
		
		//input ports
		.clk(wr_clk_seven_segment),
		.reset(reset),
		.count(wr_count),
		
		//output ports
		.rg_anode(wr_anode),
		.rg_cathode(wr_cathode)
	);
//------------------------------------------------------------------
//----------------------hardware action-----------------------------
//------------------------------------------------------------------
endmodule
