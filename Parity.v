module Patity_Calc (

input wire [7:0] p_data,
input wire data_valid,
input wire par_typ,
output reg par_bit,
input wire clk,
input wire rst

);

always @ (*)
begin
  
  if (par_typ == 1'b1 && data_valid)       // odd parity
    begin
      par_bit <= ~ (^p_data);
    end  
    
  else if (par_typ == 1'b0 && data_valid)      // even parity
    begin
      par_bit <= ^p_data;  
    end  

end  

endmodule