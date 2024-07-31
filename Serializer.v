module serializer(

input wire [7:0] p_data,
input wire data_valid,
input wire ser_en,
input wire busy,
input wire clk,
input wire rst,
output wire ser_done,
output reg ser_data

);

reg [3:0] counter;
reg [7:0] bits_to_send;

always @ (posedge clk or negedge rst)
begin

  if (!rst)
    begin
      bits_to_send <= 8'b0;
	  ser_data <= 1'b0;
    end
    
  else if (data_valid && !busy)
    begin
      bits_to_send <= p_data;
    end
  
  else if (ser_en)
    begin 
	ser_data <= bits_to_send[0];  
    bits_to_send <= {1'b0, bits_to_send[7:1]};
	end
end 

//Counter   
always @ (posedge clk or negedge rst)
begin

  if (!rst)
    begin
	    counter <= 'b0;
    end
	
  else if (ser_en)
    begin
	    counter <= counter + 1;  
	end
	
  else
      counter <= 'b0;  
end 

// serial done
assign ser_done = (counter == 'd8) ? 1'b1:1'b0 ;
endmodule 
