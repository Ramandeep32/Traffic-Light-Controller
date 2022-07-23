`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04.05.2022 13:52:38
// Design Name: 
// Module Name: Traffic_light_controller
// Project Name: 
// Target Devices: 
// Tool Versions: 
// Description: 
// 
// Dependencies: 
// 
// Revision:
// Revision 0.01 - File Created
// Additional Comments:
// 
//////////////////////////////////////////////////////////////////////////////////


module Traffic_light_controller(sen,clk,rst,north_l,south_l,east_l,west_l,co,seg);
input clk,rst,sen;
output reg [2:0]north_l,south_l,east_l,west_l;
parameter [1:0] north=2'b00;
parameter [1:0] south=2'b01;
parameter [1:0] east=2'b10;
parameter [1:0] west=2'b11;



reg [1:0] state;
reg [2:0]count;
output co;

reg [27:0]var=0;
output [6:0]seg;
assign co=var[27];

always@(posedge clk)
begin
  var<=var+1;
end
always@(posedge clk)
begin
case(state)
north:if(sen)
           begin
               state=east;
               north_l=3'b100;
               south_l=3'b100;
               east_l=3'b001;
               west_l=3'b100;
               count=0;
               end
east:if(sen)
begin
          state=south;
          north_l=3'b100;
          south_l=3'b001;
          east_l=3'b100;
          west_l=3'b100;
          count=0;
      end 
south:if(sen)
                   begin
                      state=west;
                      north_l=3'b100;
                      south_l=3'b100;
                      east_l=3'b100;
                      west_l=3'b001;
                      count=0;
                   end
 west:if(sen)
                        begin
                              state=north;
                              north_l=3'b001;
                              south_l=3'b100;
                              east_l=3'b100;
                              west_l=3'b100;
                              count=0;
                        end
                        endcase
               
end
always@(posedge co,posedge rst)
    begin
        if(rst)
            begin
                state=north;
                count=0;
            end
        else
            begin
                case(state)
                    north:
                              if(count<3)
                               begin
                                state=north;
                                north_l=3'b001;
                                south_l=3'b100;
                                east_l=3'b100;
                                west_l=3'b100;
                                count=count+1;
                                if(count>2)
                                    begin
                                        north_l=3'b001;
                                        south_l=3'b100;
                                        west_l=3'b100;
                                        east_l=3'b010;
                                    end
                            end
                            else
                          begin
                              state=east;
                              north_l=3'b100;
                              south_l=3'b100;
                              east_l=3'b001;
                              west_l=3'b100;
                              count=0;
                          end 
                           
                    east:
                        
                      if(count<3)
                            begin
                                state=east;   
                                north_l=3'b100;
                                south_l=3'b100;
                                east_l=3'b001;
                                west_l=3'b100;
                                count=count+1;    
                                if(count>2)
                                    begin
                                        north_l=3'b100;
                                        
                                        east_l=3'b001;
                                        west_l=3'b100;
                                        south_l=3'b010;
                                    end
                            end
                         else
                         begin
                              state=south;
                              north_l=3'b100;
                              south_l=3'b001;
                              east_l=3'b100;
                              west_l=3'b100;
                              count=0;
                         end
                        
                    south:
                           if(count<3)
                            begin
                                state=south;   
                                north_l=3'b100;
                                south_l=3'b001;
                                east_l=3'b100;
                                west_l=3'b100;
                                count=count+1;    
                                if(count>2)
                                    begin
                                        north_l=3'b100;
                                        south_l=3'b001;
                                        east_l=3'b100;
                                        
                                        west_l=3'b010;
                                    end
                            end
                         else
                         begin
                              state=west;
                              north_l=3'b100;
                              south_l=3'b100;
                              east_l=3'b100;
                              west_l=3'b001;
                              count=0;
                         end  
                                          
                  west:
                          if(count<3)
                            begin
                                state=west;   
                                north_l=3'b100;
                                south_l=3'b100;
                                east_l=3'b100;
                                west_l=3'b001;
                                count=count+1;    
                                if(count>2)
                                    begin
                                    
                                    south_l=3'b100;
                                    east_l=3'b100;
                                    west_l=3'b001;
                                        north_l=3'b010;
                                    end
                            end
                         else
                         begin
                              state=north;
                              north_l=3'b001;
                              south_l=3'b100;
                              east_l=3'b100;
                              west_l=3'b100;
                              count=0;
                         end        
                                                                                      
                endcase
        end
end                    
Bcd_sevensegment B1(count,seg);
endmodule
