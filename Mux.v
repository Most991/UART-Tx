module Mux (

input wire [1:0] mux_sel,
input wire ser_data,
input wire par_bit,
input wire clk,
input wire rst,
output reg TX_out

);



always @ (*)
begin
	  case(mux_sel)
	    2'b00:  TX_out = 1'b0;
		  2'b01:  TX_out = 1'b1;
	    2'b10:  TX_out = ser_data;
		  2'b11:  TX_out = par_bit;	  
    endcase		

end
endmodule 

