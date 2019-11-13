//author : Aditya Terkar, 16EC01003, IIT Bhubaneswar
//aim : clock divider

module mod_clock_divider (

	//input ports
	input clk,
	input reset,
	//output ports
	output reg div_clk,
);

//-----------------------parameters---------------------------------
	parameter counter_size = 32;
	parameter on_count  = 80;
	parameter off_count  = 80;
//------------------------------------------------------------------
//---------------------internal wires, registers--------------------
	reg [counter_size : 0] rg_counter;
//------------------------------------------------------------------
//------------------module instantiations---------------------------
//------------------------------------------------------------------
//----------------------hardware action-----------------------------

	//increment the counter
	always @(posedge clk) begin
		if (reset == 1'b1) begin 
			rg_counter <= 32'h00000000;
		end else begin 
			if (rg_count < (on_count + off_count)) rg_count <= rg_count + 1;
			else rg_count <= 0;
		end
	end

	//output from the counter;
	always  @(*) div_clk = (rg_count < on_count) ? 1'b1 : 1'b0;

//------------------------------------------------------------------
endmodule
