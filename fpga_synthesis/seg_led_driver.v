module seg_led_driver(
    input [3:0] data_0,
    input [3:0] data_1,
    input [3:0] data_2,
    input [3:0] data_3,
    input clk,
    input reset,
   
    output reg [3:0] anode,
    output reg [6:0] cathode
    );
   
    reg [31 : 0] internal_reg;
    reg condition;
    reg [2:0] disp;
    reg [6 : 0] led_data_0, led_data_1, led_data_2, led_data_3;
   
    always @(posedge clk) begin
        if(reset) internal_reg <= 0;
        else if (internal_reg < 150000) internal_reg <= internal_reg + 1;
        else internal_reg <= 0;
    end
   
    always @(posedge clk) begin
        if (internal_reg < 75000) condition <= 1'b1;
        else condition <= 1'b0;
    end
   
    always @(posedge condition) begin
        if(reset) disp <= 0;
        else if (disp == 3'b101) disp <= 3'b001;
        else disp <= disp + 1;
//        if (reset) anode <= 4'b0000;
//        else begin
//            if ((anode == 4'b0000) || (anode == 4'b0111)) anode <= 4'b1110;
//            if(anode == 4'b1110) anode <= 4'b1101;
//            if(anode == 4'b1101) anode <= 4'b1011;
//            if(anode == 4'b1011) anode <= 4'b0111;
//        end
    end
   
    always @(posedge condition) begin
        case (disp)
            3'b000 : begin anode <= 4'b0000; cathode <= 8'b00000000; end
            3'b001 : begin anode <= 4'b1110; cathode <= led_data_0; end
            3'b010 : begin anode <= 4'b1101; cathode <= led_data_1; end
            3'b011 : begin anode <= 4'b1011; cathode <= led_data_2; end
            3'b100 : begin anode <= 4'b0111; cathode <= led_data_3; end
        endcase
    end
   
   
    always @(*) begin
        case (data_0)
            4'b0000: led_data_0 = 7'b0000001; // "0"    
            4'b0001: led_data_0 = 7'b1001111; // "1"
            4'b0010: led_data_0 = 7'b0010010; // "2"
            4'b0011: led_data_0 = 7'b0000110; // "3"
            4'b0100: led_data_0 = 7'b1001100; // "4"
            4'b0101: led_data_0 = 7'b0100100; // "5"
            4'b0110: led_data_0 = 7'b0100000; // "6"
            4'b0111: led_data_0 = 7'b0001111; // "7"
            4'b1000: led_data_0 = 7'b0000000; // "8"    
            4'b1001: led_data_0 = 7'b0000100; // "9"
            4'b1001: led_data_0 = 7'b0000010; // "a"
            4'b1001: led_data_0 = 7'b1100000; // "b"
            4'b1001: led_data_0 = 7'b0110000; // "C"
            4'b1001: led_data_0 = 7'b1000010; // "d"
            4'b1001: led_data_0 = 7'b0010000; // "E"
            4'b1001: led_data_0 = 7'b0111000; // "F"
            default: led_data_0 = 7'b0000001; // "0"
        endcase
    end
   
     always @(*) begin
        case (data_1)
            4'b0000: led_data_1 = 7'b0000001; // "0"    
            4'b0001: led_data_1 = 7'b1001111; // "1"
            4'b0010: led_data_1 = 7'b0010010; // "2"
            4'b0011: led_data_1 = 7'b0000110; // "3"
            4'b0100: led_data_1 = 7'b1001100; // "4"
            4'b0101: led_data_1 = 7'b0100100; // "5"
            4'b0110: led_data_1 = 7'b0100000; // "6"
            4'b0111: led_data_1 = 7'b0001111; // "7"
            4'b1000: led_data_1 = 7'b0000000; // "8"    
            4'b1001: led_data_1 = 7'b0000100; // "9"
            4'b1001: led_data_1 = 7'b0000010; // "a"
            4'b1001: led_data_1 = 7'b1100000; // "b"
            4'b1001: led_data_1 = 7'b0110000; // "C"
            4'b1001: led_data_1 = 7'b1000010; // "d"
            4'b1001: led_data_1 = 7'b0010000; // "E"
            4'b1001: led_data_1 = 7'b0111000; // "F"
            default: led_data_1 = 7'b0000001; // "0"
        endcase
    end
   
     always @(*) begin
        case (data_2)
            4'b0000: led_data_2 = 7'b0000001; // "0"    
            4'b0001: led_data_2 = 7'b1001111; // "1"
            4'b0010: led_data_2 = 7'b0010010; // "2"
            4'b0011: led_data_2 = 7'b0000110; // "3"
            4'b0100: led_data_2 = 7'b1001100; // "4"
            4'b0101: led_data_2 = 7'b0100100; // "5"
            4'b0110: led_data_2 = 7'b0100000; // "6"
            4'b0111: led_data_2 = 7'b0001111; // "7"
            4'b1000: led_data_2 = 7'b0000000; // "8"    
            4'b1001: led_data_2 = 7'b0000100; // "9"
            4'b1001: led_data_2 = 7'b0000010; // "a"
            4'b1001: led_data_2 = 7'b1100000; // "b"
            4'b1001: led_data_2 = 7'b0110000; // "C"
            4'b1001: led_data_2 = 7'b1000010; // "d"
            4'b1001: led_data_2 = 7'b0010000; // "E"
            4'b1001: led_data_2 = 7'b0111000; // "F"
            default: led_data_2 = 7'b0000001; // "0"
        endcase
    end
   
     always @(*) begin
        case (data_3)
            4'b0000: led_data_3 = 7'b0000001; // "0"    
            4'b0001: led_data_3 = 7'b1001111; // "1"
            4'b0010: led_data_3 = 7'b0010010; // "2"
            4'b0011: led_data_3 = 7'b0000110; // "3"
            4'b0100: led_data_3 = 7'b1001100; // "4"
            4'b0101: led_data_3 = 7'b0100100; // "5"
            4'b0110: led_data_3 = 7'b0100000; // "6"
            4'b0111: led_data_3 = 7'b0001111; // "7"
            4'b1000: led_data_3 = 7'b0000000; // "8"    
            4'b1001: led_data_3 = 7'b0000100; // "9"
            4'b1001: led_data_3 = 7'b0000010; // "a"
            4'b1001: led_data_3 = 7'b1100000; // "b"
            4'b1001: led_data_3 = 7'b0110000; // "C"
            4'b1001: led_data_3 = 7'b1000010; // "d"
            4'b1001: led_data_3 = 7'b0010000; // "E"
            4'b1001: led_data_3 = 7'b0111000; // "F"
            default: led_data_3 = 7'b0000001; // "0"
        endcase
    end
endmodule