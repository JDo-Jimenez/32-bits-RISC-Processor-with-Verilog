module decoder (mbs,negar,functout,RegWrite,MemtoReg,MemWrite,Branch,tipo,ALUsrc,opcode,functin);

input [2:0] functin;
input [3:0] opcode;
output reg RegWrite,MemtoReg,MemWrite,Branch,ALUsrc,mbs,negar;
output reg [2:0] functout;
output reg [1:0] tipo;

always @(opcode,functin)
begin
  case (opcode)
    4'b0000: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=1;negar<=1;
          end
    4'b0001: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=1;negar<=1;  
          end
    4'b0010: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=1;negar<=0;  
          end
    4'b0011: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=1;negar<=0;  
          end
    4'b0100: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=0;negar<=1;
          end
    4'b0101: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=0;negar<=1;
          end
    4'b0110: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=0;negar<=0;
          end
    4'b0111: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b010;tipo<=2'b00;ALUsrc<=0;mbs<=0;negar<=0;
          end
    4'b1000: begin
            RegWrite<=1;MemtoReg<=0;MemWrite<=0;Branch<=0;functout<=functin;tipo<=2'b00;ALUsrc<=0;mbs<=0;negar<=0;
          end 
    4'b1001: begin
            RegWrite<=1;MemtoReg<=0;MemWrite<=0;Branch<=0;functout<=functin;tipo<=2'b00;ALUsrc<=1;mbs<=0;negar<=0;
          end
    4'b1010: begin
            RegWrite<=1;MemtoReg<=1;MemWrite<=0;Branch<=0;functout<=3'b001;tipo<=2'b00;ALUsrc<=1;mbs<=0;negar<=0;
          end
    4'b1011: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=1;Branch<=0;functout<=3'b001;tipo<=2'b00;ALUsrc<=1;mbs<=0;negar<=0;
          end
    4'b1100: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=0;functout<=3'b000;tipo<=2'b00;ALUsrc<=1;mbs<=0;negar<=0;
          end
    4'b1101: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=0;functout<=3'b000;tipo<=2'b00;ALUsrc<=1;mbs<=0;negar<=0;
          end
    4'b1110: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b001;tipo<=2'b01;ALUsrc<=1;mbs<=0;negar<=0; // ojo!!! suma inmediato a registro!
          end
    4'b1111: begin
            RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;functout<=3'b001;tipo<=2'b10;ALUsrc<=0;mbs<=0;negar<=0; // ojo!!! salta un inmediato directamente!
          end
  endcase    
end

endmodule
//  R-type    3   - 1 - 4  - 4  -   3   - 4  - 13
//(tipo 00)opcode - I - rd - rs - funct - rt - sin uso
//
//  I-type    3   - 1 - 4  - 4  -   3   - 17
//(tipo 00)opcode - I - rd - rs - funct - direccion/inmediato
//
//  X-type    3   - 1 - 4  - 4  - 20
//(tipo 01)opcode - I - rd - rs - direccion/inmediato
//
//  Y-type    3   - 1 - 4  - 24
//(tipo 10)opcode - I - rs - direccion/inmediato
//
//  J-type    3   - 1 - 28
//(tipo 11)opcode - I - direccion/inmediato
//
//
//    tabla asignacion opcode:                            tabla asignación funct:
//      000 bgt                                             000 zero=1
//      001 blt                                             001 add
//      010 bne                                             010 sub
//      011 beq                                             011 and
//      100 operaciones aritmético-logicas                  100 or
//      101 lw/sw                                           101 not
//      110 nop                                             110 xor
//      111 jump                                            111 ---
//    
//  el bit "I" (4º bit) diferencia si es operacion inmediata de no inmediata salvo para lw/sw 
//  que identifica precisamente si es lw o sw. 
//  
//  Por defecto I<=0-->no inmediato/lw, I<=1-->inmediato/sw


//
//opcode-I

//   000-?  --> bgt   : RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;funct<=010;tipo<=01;ALUsrc<=0;mbs=1;negar=1;  posible selector zero/mbs-->si mbs=0 salta! (AND con Branch)
//   001-?  --> blt   : RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;funct<=010;tipo<=01;ALUsrc<=0;mbs=1;negar=0;  posible selector zero/mbs-->si mbs=1 salta! (AND con Branch)
//   010-?  --> bne   : RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;funct<=010;tipo<=01;ALUsrc<=0;mbs=0;negar=1;  si zero=0 salta! (AND con Branch)
//   011-?  --> beq   : RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;funct<=010;tipo<=01;ALUsrc<=0;mbs=0;negar=0;  si zero=1 salta! (AND con Branch)
//   100-0  --> OAL   : RegWrite<=1;MemtoReg<=0;MemWrite<=0;Branch<=0;funct<=???;tipo<=00;ALUsrc<=0;mbs=0;negar=0;
//   100-1  --> OAL(I): RegWrite<=1;MemtoReg<=0;MemWrite<=0;Branch<=0;funct<=???;tipo<=00;ALUsrc<=1;mbs=0;negar=0;  !!!ojo!!!->hay ke poner un selector para la posición de funct según el bit I
//   101-0  --> lw    : RegWrite<=1;MemtoReg<=1;MemWrite<=0;Branch<=0;funct<=001;tipo<=01;ALUsrc<=1;mbs=0;negar=0;
//   101-1  --> sw    : RegWrite<=0;MemtoReg<=0;MemWrite<=1;Branch<=0;funct<=001;tipo<=01;ALUsrc<=1;mbs=0;negar=0;
//   110-?  --> nop   : RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=0;funct<=000;tipo<=00;ALUsrc<=1;mbs=0;negar=0;
//   111-0  --> jump  : RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;funct<=001;tipo<=10;ALUsrc<=1;mbs=0;negar=0;
//   111-1  --> jump  : RegWrite<=0;MemtoReg<=0;MemWrite<=0;Branch<=1;funct<=001;tipo<=11;ALUsrc<=0;mbs=0;negar=0;
//   ****revisar comportamiento de jump, porque es distinta a todas, posible implementación 
//       utilizando func


//  IF - ID - EX - Mem - WB


//    Significado de las señales de control(la mayoría son señales de control de un multiplexador):
//
//    RegWrite --> activa la entrada write del banco de registros
//    MemtoReg --> indica si la salida de la orden proviene de la ALU(0) o de memoria(1)
//    MemWrite --> activa la entrada write de la memoria de datos
//    Branch   --> indica si la orden es un salto(1) o no(0)
//    funct    --> indica a la ALU la operación a efectuar
//    tipo     --> indica el tipo de inmediato, si es de 20 bits(0) o 28 bits(1)
//    ALUsrc   --> indica si la operación es sobre un registro(0) o un inmediato(1)[en el caso de jump indica si se direcciona a inm+reg(1) o sólo a inm(0)]




