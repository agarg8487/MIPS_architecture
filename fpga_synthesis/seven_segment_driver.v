//author : Aditya Terkar, 16EC01003, IIT Bhubaneswar
//aim : clock divider

module mod_seven_segment_driver (

	//input ports
	input clk,
	input reset,
	input wire [3 : 0] count,
						
	//output ports
	output reg [3 : 0] rg_anode,  //active low anode
	output reg [7 : 0] rg_cathode, // active low cathode

);

//-----------------------parameters---------------------------------
//------------------------------------------------------------------
//------------------module instantiations---------------------------
//------------------------------------------------------------------
//----------------------hardware action-----------------------------
	
	//control the anode register
	//rg_anode = {an3,an2,an1,an0}
	always @(posedge clk) begin
		if (reset == 1'b1) rg_anode <= 4'b0000; //activate all the anodes
		else begin
			case (rg_anode) 
				4'b0000 : rg_anode <= 4'b1110; //activate the first segment
				4'b1110 : rg_anode <= 4'b1101; //activate the second segment
				4'b1101 : rg_anode <= 4'b1011; //activate the third segment
 				4'b1011 : rg_anode <= 4'b0111; //activate the fourth segment
				4'b0111 : rg_anode <= 4'b1110; //activate the first segment
				default : rg_anode <= 4'b0000; //activate all in default
			endcase
		end
	end
	
	//drive the cathode register
	//rg_cathode = {A,B,C,D,E,F,G,Dp}
	always @(*) begin
		case (rg_anode)
			4'b0000 : rg_cathode = 8'b11111100; //display '-.-.-.-.' in reset
			4'b1011, 4'b0111 : rg_cathode = 8'b00000011; //display '0' in third and fourth displays

			4'b1101 : begin
				//display '0' in second segment if count is < 10 else '1'
				if (count < 10) rg_cathode = 8'b00000011; 
				else rg_cathode = 8'b10011111;
			end
			
			4'b0111 : begin
				case (count)
					4'h0 : rg_cathode = 8'b00000011; 
					4'h1 : rg_cathode = 8'b10011111; 
					4'h2 : rg_cathode = 8'b00100101; 
					4'h3 : rg_cathode = 8'b00001101; 
					4'h4 : rg_cathode = 8'b10010001; 
					4'h5 : rg_cathode = 8'b01001001; 
					4'h6 : rg_cathode = 8'b01000001; 
					4'h7 : rg_cathode = 8'b00011111; 
					4'h8 : rg_cathode = 8'b00000001; 
					4'h9 : rg_cathode = 8'b00011001; 
					4'ha : rg_cathode = 8'b00000011; 
					4'hb : rg_cathode = 8'b10011111; 
					4'hc : rg_cathode = 8'b00100101; 
					4'hd : rg_cathode = 8'b00001101; 
					4'he : rg_cathode = 8'b10010001; 
					4'hf : rg_cathode = 8'b01001001;   
				endcase
			end
		endcase
	end
//------------------------------------------------------------------
endmodule
