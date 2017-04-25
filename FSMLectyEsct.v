`timescale 1ns / 1ps
//////////////////////////////////////////////////////////////////////////////////
// Company: 
// Engineer: 
// 
// Create Date: 04/01/2017 02:33:22 PM
// Design Name: 
// Module Name: FSMLectyEsct
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


module FSMLectyEsct(
	input wire clk,
	input wire reset,//Reset general del sistema
	input wire in_escribir_leer,//entrada de si se quiere escribir o leer
	input wire en_funcion, //que alista al estado anterior a pasar a un estado siguiente
	
	//Senales de control RTC
	output reg reg_a_d, //A/D
	output reg reg_cs,//Chip select
	output reg reg_wr, //Write
	output reg reg_rd,//Read
	//Indicadores de trabajo
	output reg out_flag_capturar_dato,//Bandera que indica si se obtuvo el dato
	output reg out_direccion_dato,//Bandera que indica si se direcciono el dato
	output reg reg_funcion_r_w,//Indica si se desea escribir o leer
	output wire flag_done,//Bandera que indica que el proceso termino
	output wire [4:0]q //Representa un estado presente del contador
	  
    ); 
/////parametros de estado
localparam
espera = 1'b1, //Primer estado de la maquina
leer_escribir = 1'b0;//Segundo estado de la maquina
	 
// Bits del contador para generar una señal periódica de (2^N)*10ns
localparam N = 5;


// Declaración de señales
reg [N-1:0] q_reg;
reg [N-1:0] q_next;
reg state_reg, state_next;
reg reset_count;

//Descripción del comportamiento

//=============================================
// Contador para generar un pulso de(2^N)*10ns
//=============================================
always @(posedge clk, posedge reset_count)
begin
    if (reset_count) q_reg <= 0;//Esto indica que si recibe un reset, se quede en cero y no cuente
	 else  q_reg <= q_next;	 //y si no entonces que empiece a contar 
end
always@*
begin
q_next <= q_reg + 1'b1;//que cuente de uno en uno
end



// Pulso de salida
assign flag_done = (q_reg == 20) ? 1'b1 : 1'b0;//Esta bandera se activa cuando el contador llegue a 20 de uno en uno
assign q = q_reg;//Se asigna el estado q del contador a la salida 

 
///logica secuencial

//=============================================
// Inicio de la FSM
//=============================================

always @(posedge clk, posedge reset)
begin
  if (reset) //Al tener un pulso de reset, se queda en el estado inicial espera
     state_reg <= espera;
  else
     state_reg <= state_next;//Sino sigue al estado siguiente
end
// Lógica de estado siguiente y salida
  always@*
   begin
	

	state_next = state_reg;  // default state: the same
	
	
	case(state_reg)
	espera://Estado de espera en donde las senales estan en alto, 
	//no se captura dato, ni se obtiene direccion, el reset del 
	//contador se activa para no contar hasta que se pase al estado siguiente 
	//Se puede corroborar con la grafica los estados en alto y en bajo y que pasa en cada momento 
		begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			reg_a_d = 1'b1;
			reg_funcion_r_w = 1'b0;
			out_direccion_dato = 1'b0;
			reset_count = 1'b1;
			out_flag_capturar_dato = 1'b0;
			if(en_funcion) //Al activarse esta entrada por el usuario, se pasa al estado de lectura y escritura
			begin
			state_next = leer_escribir; //Asigna al estado siguiente el de leer escribir
			end

			else
			begin//y por default sino, que se quede en espera de una senal
			state_next = espera;

			end
		end
	
	//Logica del siguiente estado: Leer o escribir
		
	leer_escribir: 
	begin
	reset_count = 1'b0;
	//Proseso de lectura_escritura	
	case(q_reg)
		5'd0: begin //inicia 
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_rd = 1'b1;
			reg_wr = 1'b1;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			out_direccion_dato = 1'b0;
		end 
		5'd1: begin // baja salida a_d
			reg_a_d = 1'b0;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b0;
		end
		
		5'd2: begin// baja cs con wr o rd incio de manipulacion del bis de datos
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
		5'd3: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd4: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd5: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		
		5'd6: begin
			reg_a_d = 1'b0;
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			
		5'd7:begin 
			reg_a_d = 1'b0;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd8: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
		end
		5'd9: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		5'd10: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		5'd11: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			end
		5'd12: begin
			reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		5'd13: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd14:begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd15:begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			end
		end
		5'd16: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd17: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end
		end
		5'd18: begin
			reg_a_d = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_cs = 1'b0;
			reg_wr = 1'b0;
			reg_rd = 1'b1;
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_cs = 1'b0;
			reg_wr = 1'b1;
			reg_rd = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
		end end
		
		5'd19: begin reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b1;
			if (in_escribir_leer)begin
			reg_funcion_r_w = 1'b1;
			out_flag_capturar_dato = 1'b1;
			end
			else begin
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			end
			end
		5'd20:
		begin reg_a_d = 1'b1;
			reg_cs = 1'b1;
			reg_wr = 1'b1;
			reg_rd = 1'b1;
			out_direccion_dato = 1'b0;
			reg_funcion_r_w = 1'b0;
			out_flag_capturar_dato = 1'b0;
			
		end
		
		default: begin 
		state_next = leer_escribir;
		reg_a_d = 1'b1;
		reg_cs =  1'b1;
		reg_rd =  1'b1;
		reg_wr =  1'b1;
		out_direccion_dato =  1'b0;
		reg_funcion_r_w =  1'b0;
		out_flag_capturar_dato = 1'b0;
		end 
		endcase	 
	end
	default: begin
	state_next = espera;
	reg_cs = 1'd1;
	reg_a_d = 1'd1;
	reg_wr = 1'd1;
	reg_rd = 1'd1;
	reg_funcion_r_w = 1'd0;
	out_direccion_dato = 1'd0;
	end
	endcase
	
   end

endmodule
