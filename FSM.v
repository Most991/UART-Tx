module FSM (

input wire data_valid,
input wire par_en,
input wire ser_done,
input wire clk,
input wire rst,
output reg busy,
output reg [1:0] mux_sel,
output reg ser_en

);

parameter idle        = 3'b000, 
          start       = 3'b001,
          data        = 3'b010,
          parity      = 3'b011,
          stop        = 3'b100;
           
reg [2:0] cur_st;
reg [2:0] next_st;

always @ (posedge clk or negedge rst)
begin
  if (!rst)
    begin
      busy <= 1'b0;
      cur_st <= idle;
      mux_sel = 2'b01;      
    end 
    
  else 
    begin
      cur_st <= next_st;
    end   
end

always @ (*)
  begin
    case (cur_st)
///////////////////////////////////////////////      
      idle: begin
              if (data_valid) begin
                  next_st = start;
                  mux_sel = 2'b00;
              end else
                begin
                  next_st = idle;
                  busy = 1'b0;
                  mux_sel = 2'b01;
                end  
            end
///////////////////////////////////////////////            
      start:begin
             mux_sel = 2'b10;
             busy = 1'b1;
             ser_en = 1'b1;
             next_st = data; 
            end
///////////////////////////////////////////////
      data:begin             
             if(!ser_done)
               begin  
                 mux_sel = 2'b10;
                 next_st = data;
               end
             else
               begin
                 if(par_en)
                   begin
                     next_st = parity;
                     ser_en = 1'b0;
                   end
                 else
                   begin
                     next_st = stop;
                     ser_en = 1'b0;
                   end
                end      
           end
///////////////////////////////////////////////           
      parity:begin
               mux_sel = 2'b11;
               next_st = stop; 
             end
///////////////////////////////////////////////           
      stop:begin
             mux_sel = 2'b01;
             next_st = idle; 
           end
    endcase        
  end  

endmodule
