/*
  Project: Scrolling message on LED dot matrix display
  MCU: PIC18F2550 @ 48.0 MHz (StartUSB for PIC board)
  Copyright @ Rajendra Bhatt
  May 16, 2011
*/
 sbit Serial_Data at RC2_bit;
 sbit SH_Clk at RC6_bit;
 sbit ST_Clk at RC7_bit;
 sbit CD4017_Clk at RA2_bit;
 sbit CD4017_RST at RA1_bit;

void send_data(unsigned int temp){
 unsigned int Mask = 0x01, t, Flag;
  for (t=0; t<16; t++){
   Flag = temp & Mask;
   if(Flag==0) Serial_Data = 0;
   else Serial_Data = 1;
   SH_Clk = 1;
   SH_Clk = 0;
   Mask = Mask << 1;
  }
  // Apply clock on ST_Clk
  ST_Clk = 1;
  ST_Clk = 0;

}
/* CharData is a two dimensional constant array that holds the 8-bit column values of
   individual rows for ASCII characters that are to be displayed on a 8x8 matrix format.
*/
const unsigned short CharData[][8] ={
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000100},
{0b00001010, 0b00001010, 0b00001010, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00001010, 0b00011111, 0b00001010, 0b00011111, 0b00001010, 0b00011111, 0b00001010},
{0b00000111, 0b00001100, 0b00010100, 0b00001100, 0b00000110, 0b00000101, 0b00000110, 0b00011100},
{0b00011001, 0b00011010, 0b00000010, 0b00000100, 0b00000100, 0b00001000, 0b00001011, 0b00010011},
{0b00000110, 0b00001010, 0b00010010, 0b00010100, 0b00001001, 0b00010110, 0b00010110, 0b00001001},
{0b00000100, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000010, 0b00000100, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00000100, 0b00000010},
{0b00001000, 0b00000100, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00000100, 0b00001000},
{0b00010101, 0b00001110, 0b00011111, 0b00001110, 0b00010101, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00011111, 0b00000100, 0b00000100, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000110, 0b00000100, 0b00001000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000100},
{0b00000001, 0b00000010, 0b00000010, 0b00000100, 0b00000100, 0b00001000, 0b00001000, 0b00010000},
{0b00001110, 0b00010001, 0b00010011, 0b00010001, 0b00010101, 0b00010001, 0b00011001, 0b00001110},
{0b00000100, 0b00001100, 0b00010100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00011111},
{0b00001110, 0b00010001, 0b00010001, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00011111},
{0b00001110, 0b00010001, 0b00000001, 0b00001110, 0b00000001, 0b00000001, 0b00010001, 0b00001110},
{0b00010000, 0b00010000, 0b00010100, 0b00010100, 0b00011111, 0b00000100, 0b00000100, 0b00000100},
{0b00011111, 0b00010000, 0b00010000, 0b00011110, 0b00000001, 0b00000001, 0b00000001, 0b00011110},
{0b00000111, 0b00001000, 0b00010000, 0b00011110, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00011111, 0b00000001, 0b00000001, 0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00010000},
{0b00001110, 0b00010001, 0b00010001, 0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00001110, 0b00010001, 0b00010001, 0b00001111, 0b00000001, 0b00000001, 0b00000001, 0b00000001},
{0b00000000, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00000000},
{0b00000000, 0b00000100, 0b00000100, 0b00000000, 0b00000000, 0b00000100, 0b00000100, 0b00001000},
{0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00001000, 0b00000100, 0b00000010, 0b00000001},
{0b00000000, 0b00000000, 0b00000000, 0b00011110, 0b00000000, 0b00011110, 0b00000000, 0b00000000},
{0b00010000, 0b00001000, 0b00000100, 0b00000010, 0b00000010, 0b00000100, 0b00001000, 0b00010000},
{0b00001110, 0b00010001, 0b00010001, 0b00000010, 0b00000100, 0b00000100, 0b00000000, 0b00000100},
{0b00001110, 0b00010001, 0b00010001, 0b00010101, 0b00010101, 0b00010001, 0b00010001, 0b00011110},
{0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00011111, 0b00010001, 0b00010001, 0b00010001},//A
{0b00011110, 0b00010001, 0b00010001, 0b00011110, 0b00010001, 0b00010001, 0b00010001, 0b00011110},
{0b00000111, 0b00001000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00001000, 0b00000111},
{0b00011100, 0b00010010, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010010, 0b00011100},
{0b00011111, 0b00010000, 0b00010000, 0b00011110, 0b00010000, 0b00010000, 0b00010000, 0b00011111},
{0b00011111, 0b00010000, 0b00010000, 0b00011110, 0b00010000, 0b00010000, 0b00010000, 0b00010000},
{0b00001110, 0b00010001, 0b00010000, 0b00010000, 0b00010111, 0b00010001, 0b00010001, 0b00001110},
{0b00010001, 0b00010001, 0b00010001, 0b00011111, 0b00010001, 0b00010001, 0b00010001, 0b00010001},
{0b00011111, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00011111},
{0b00011111, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00010100, 0b00001000},
{0b00010001, 0b00010010, 0b00010100, 0b00011000, 0b00010100, 0b00010010, 0b00010001, 0b00010001},
{0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00011111},
{0b00010001, 0b00011011, 0b00011111, 0b00010101, 0b00010001, 0b00010001, 0b00010001, 0b00010001},
{0b00010001, 0b00011001, 0b00011001, 0b00010101, 0b00010101, 0b00010011, 0b00010011, 0b00010001},
{0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00011110, 0b00010001, 0b00010001, 0b00011110, 0b00010000, 0b00010000, 0b00010000, 0b00010000},
{0b00001110, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010101, 0b00010011, 0b00001111},
{0b00011110, 0b00010001, 0b00010001, 0b00011110, 0b00010100, 0b00010010, 0b00010001, 0b00010001},
{0b00001110, 0b00010001, 0b00010000, 0b00001000, 0b00000110, 0b00000001, 0b00010001, 0b00001110},
{0b00011111, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00001110},
{0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00001010, 0b00000100},
{0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010001, 0b00010101, 0b00010101, 0b00001010},
{0b00010001, 0b00010001, 0b00001010, 0b00000100, 0b00000100, 0b00001010, 0b00010001, 0b00010001},
{0b00010001, 0b00010001, 0b00001010, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00011111, 0b00000001, 0b00000010, 0b00000100, 0b00001000, 0b00010000, 0b00010000, 0b00011111},
{0b00001110, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00001000, 0b00001110},
{0b00010000, 0b00001000, 0b00001000, 0b00000100, 0b00000100, 0b00000010, 0b00000010, 0b00000001},
{0b00001110, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00001110},
{0b00000100, 0b00001010, 0b00010001, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00011111},
{0b00001000, 0b00000100, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000, 0b00000000},
{0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00010010, 0b00010010, 0b00010010, 0b00001111},
{0b00000000, 0b00010000, 0b00010000, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00011100},
{0b00000000, 0b00000000, 0b00000000, 0b00001110, 0b00010000, 0b00010000, 0b00010000, 0b00001110},
{0b00000000, 0b00000001, 0b00000001, 0b00000001, 0b00000111, 0b00001001, 0b00001001, 0b00000111},
{0b00000000, 0b00000000, 0b00000000, 0b00011100, 0b00010010, 0b00011110, 0b00010000, 0b00001110},
{0b00000000, 0b00000011, 0b00000100, 0b00000100, 0b00000110, 0b00000100, 0b00000100, 0b00000100},
{0b00000000, 0b00001110, 0b00001010, 0b00001010, 0b00001110, 0b00000010, 0b00000010, 0b00001100},
{0b00000000, 0b00010000, 0b00010000, 0b00010000, 0b00011100, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00000000, 0b00000100, 0b00000000, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00000000, 0b00000010, 0b00000000, 0b00000010, 0b00000010, 0b00000010, 0b00000010, 0b00001100},
{0b00000000, 0b00010000, 0b00010000, 0b00010100, 0b00011000, 0b00011000, 0b00010100, 0b00010000},
{0b00000000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00010000, 0b00001100},
{0b00000000, 0b00000000, 0b00000000, 0b00001010, 0b00010101, 0b00010001, 0b00010001, 0b00010001},
{0b00000000, 0b00000000, 0b00000000, 0b00010100, 0b00011010, 0b00010010, 0b00010010, 0b00010010},
{0b00000000, 0b00000000, 0b00000000, 0b00001100, 0b00010010, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00011100, 0b00010010, 0b00010010, 0b00011100, 0b00010000, 0b00010000, 0b00010000},
{0b00000000, 0b00001110, 0b00010010, 0b00010010, 0b00001110, 0b00000010, 0b00000010, 0b00000001},
{0b00000000, 0b00000000, 0b00000000, 0b00001010, 0b00001100, 0b00001000, 0b00001000, 0b00001000},
{0b00000000, 0b00000000, 0b00001110, 0b00010000, 0b00001000, 0b00000100, 0b00000010, 0b00011110},
{0b00000000, 0b00010000, 0b00010000, 0b00011100, 0b00010000, 0b00010000, 0b00010000, 0b00001100},
{0b00000000, 0b00000000, 0b00000000, 0b00010010, 0b00010010, 0b00010010, 0b00010010, 0b00001100},
{0b00000000, 0b00000000, 0b00000000, 0b00010001, 0b00010001, 0b00010001, 0b00001010, 0b00000100},
{0b00000000, 0b00000000, 0b00000000, 0b00010001, 0b00010001, 0b00010001, 0b00010101, 0b00001010},
{0b00000000, 0b00000000, 0b00000000, 0b00010001, 0b00001010, 0b00000100, 0b00001010, 0b00010001},
{0b00000000, 0b00000000, 0b00010001, 0b00001010, 0b00000100, 0b00001000, 0b00001000, 0b00010000},
{0b00000000, 0b00000000, 0b00000000, 0b00011111, 0b00000010, 0b00000100, 0b00001000, 0b00011111},
{0b00000010, 0b00000100, 0b00000100, 0b00000100, 0b00001000, 0b00000100, 0b00000100, 0b00000010},
{0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100, 0b00000100},
{0b00001000, 0b00000100, 0b00000100, 0b00000100, 0b00000010, 0b00000100, 0b00000100, 0b00001000},
{0b00000000, 0b00000000, 0b00000000, 0b00001010, 0b00011110, 0b00010100, 0b00000000, 0b00000000}
};

unsigned int DisplayBuffer[]={0,0,0,0,0,0,0,0};
unsigned int speed;
short i, l, k, ShiftAmount, scroll, temp, shift_step=1, StringLength;
char message[]="USMAN ...";
char index;
void main() {
 CMCON = 0x07;   // Disable comparators
 ADCON0 = 0x00; // Select ADC channel AN0
 ADCON1 = 0b00001110;  // RA0 as analog input
 TRISC = 0x00;
 TRISB = 0x00;
 TRISA = 0x01;
 StringLength = strlen(message) ;
 do {
 for (k=0; k<StringLength; k++){
  for (scroll=0; scroll<(8/shift_step); scroll++) {
   for (ShiftAmount=0; ShiftAmount<8; ShiftAmount++){
    index = message[k];
    temp = CharData[index-32][ShiftAmount];
    DisplayBuffer[ShiftAmount] = (DisplayBuffer[ShiftAmount] << shift_step)| (temp >> ((8-shift_step)-scroll*shift_step));
   }

  speed = 10+ADC_Read(0)/10;
  for(l=0; l<speed;l++){

  PORTB = 0xFE;
  send_data(DisplayBuffer[1]);
  delay_us(10);
  PORTB = 0xFD;
  send_data(DisplayBuffer[2]);
  delay_us(10);
  PORTB = 0xFB;
  send_data(DisplayBuffer[3]);
  delay_us(10);
  PORTB = 0xF7;
  send_data(DisplayBuffer[4]);
  delay_us(10);
  PORTB = 0xEF;
  send_data(DisplayBuffer[5]);
  delay_us(10);
  PORTB = 0xDF;
  send_data(DisplayBuffer[6]);
  delay_us(10);
  PORTB = 0xBF;
  send_data(DisplayBuffer[7]);
  delay_us(10);
  PORTB = 0x7E;
  send_data(DisplayBuffer[0]);
  delay_us(10);


  /*for (i=0; i<8; i++) {

    send_data(DisplayBuffer[i]);
    CD4017_Clk = 1;
    CD4017_Clk = 0;
    Delay_ms(1);
   }  // i
   CD4017_Rst = 1;
   CD4017_Rst = 0;   */
  } // l
  } // scroll
 } // k

 } while(1);

}