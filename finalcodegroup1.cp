#line 1 "C:/Users/docker/Desktop/finalcodegroup1.c"


unsigned char start_flag = 0;
unsigned int ms_counter = 0;


void interrupt(){
 if(INTCON & 0B00000010){
 start_flag = 1;
 INTCON = INTCON & 0B11110101;
 }

 if((INTCON & 0B00000100) && (start_flag == 1)){
 TMR0 = 248;
 ms_counter++;
 INTCON = INTCON & 0B11111011;
 }
}


void CCPPWM_init(void){
 T2CON = 0x07;
 CCP1CON = 0x0C;
 CCP2CON = 0x0C;
 PR2 = 250;
}


void Move(unsigned char a, unsigned char b){
 PORTB = PORTB & 0B11110101;
 PORTB = PORTB | 0B00010100;
 CCPR2L = b;
 CCPR1L = a;
}


void Pivot_Left(unsigned char speed){
 PORTB = (PORTB & 0B11000001) | 0B00010010;
 CCPR1L = speed;
 CCPR2L = speed;
}


void my_delay_us(unsigned int us){
 unsigned int i;
 for(i = 0; i < us; i++){
 }
}

void my_delay_ms(unsigned int ms){
 unsigned int i, j;
 for(i = 0; i < ms; i++)
 for(j = 0; j < 300; j++);
}


void Pivot_Right(unsigned char speed){
 PORTB = (PORTB & 0B11000001) | 0B00001100;
 CCPR1L = speed;
 CCPR2L = speed;
}


void servo_write(unsigned char pulse_ms){
 unsigned char i;
 unsigned char low_ms;

 if(pulse_ms < 1) pulse_ms = 1;
 if(pulse_ms > 2) pulse_ms = 2;

 low_ms = 20 - pulse_ms;

 for(i = 0; i < 25; i++){
 PORTB = PORTB | 0B00100000;
 my_delay_ms(pulse_ms);
 PORTB = PORTB & 0B11011111;
 my_delay_ms(low_ms);
 }
}

void flag_down(void){ servo_write(2); }
void flag_up(void) { servo_write(1); }


unsigned int read_LDR(void){
 unsigned int adc_val;
 ADCON0 = 0B00000001;
 my_delay_us(20);
 ADCON0 = ADCON0 | 0B00000100;
 while(ADCON0 & 0B00000100);
 adc_val = (ADRESH * 256) + ADRESL;
 return adc_val;
}




unsigned int read_sonar_front_raw(void){
 unsigned int ticks, timeout;
 PORTD = PORTD & 0B11111110;
 my_delay_us(5);
 PORTD = PORTD | 0B00000001;
 my_delay_us(20);
 PORTD = PORTD & 0B11111110;
 my_delay_us(10);

 timeout = 1500;
 while(((PORTC & 0B00001000) == 0) && timeout) timeout--;
 if(timeout == 0) return 999;

 TMR1H = 0; TMR1L = 0;
 T1CON = T1CON | 0B00000001;

 timeout = 2500;
 while(((PORTC & 0B00001000) != 0) && timeout) timeout--;
 T1CON = T1CON & 0B11111110;
 if(timeout == 0) return 999;

 ticks = TMR1H;
 ticks = (ticks * 256) + TMR1L;
 return (ticks / 58);
}

unsigned int read_sonar_mid_raw(void){
 unsigned int ticks, timeout;
 unsigned char snap;
 PORTD = PORTD & 0B11111101;
 my_delay_us(5);
 PORTD = PORTD | 0B00000010;
 my_delay_us(20);
 PORTD = PORTD & 0B11111101;
 my_delay_us(10);

 timeout = 1500;
 do { snap = PORTD; if(snap & 0B01000000) break; timeout--; } while(timeout > 0);
 if(timeout == 0) return 999;

 TMR1H = 0; TMR1L = 0;
 T1CON = T1CON | 0B00000001;

 timeout = 2500;
 do { snap = PORTD; if(!(snap & 0B01000000)) break; timeout--; } while(timeout > 0);
 T1CON = T1CON & 0B11111110;
 if(timeout == 0) return 999;

 ticks = TMR1H;
 ticks = (ticks * 256) + TMR1L;
 return (ticks / 58);
}

unsigned int read_sonar_left_raw(void){
 unsigned int ticks, timeout;
 unsigned char snap;
 PORTD = PORTD & 0B11111011;
 my_delay_us(5);
 PORTD = PORTD | 0B00000100;
 my_delay_us(20);
 PORTD = PORTD & 0B11111011;
 my_delay_us(10);

 timeout = 1500;
 do { snap = PORTD; if(snap & 0B10000000) break; timeout--; } while(timeout > 0);
 if(timeout == 0) return 999;

 TMR1H = 0; TMR1L = 0;
 T1CON = T1CON | 0B00000001;

 timeout = 2500;
 do { snap = PORTD; if(!(snap & 0B10000000)) break; timeout--; } while(timeout > 0);
 T1CON = T1CON & 0B11111110;
 if(timeout == 0) return 999;

 ticks = TMR1H;
 ticks = (ticks * 256) + TMR1L;
 return (ticks / 58);
}


unsigned int filter_three(unsigned int r1, unsigned int r2, unsigned int r3){
 unsigned int temp;

 if(r1 < 2) r1 = 999;
 if(r2 < 2) r2 = 999;
 if(r3 < 2) r3 = 999;

 if(r1 > r2){ temp = r1; r1 = r2; r2 = temp; }
 if(r2 > r3){ temp = r2; r2 = r3; r3 = temp; }
 if(r1 > r2){ temp = r1; r1 = r2; r2 = temp; }

 return r2;
}


unsigned int read_sonar_front(void){
 unsigned int r1, r2, r3;
 r1 = read_sonar_front_raw();
 my_delay_ms(4);
 r2 = read_sonar_front_raw();
 my_delay_ms(4);
 r3 = read_sonar_front_raw();
 return filter_three(r1, r2, r3);
}

unsigned int read_sonar_mid(void){
 unsigned int r1, r2, r3;
 r1 = read_sonar_mid_raw();
 my_delay_ms(4);
 r2 = read_sonar_mid_raw();
 my_delay_ms(4);
 r3 = read_sonar_mid_raw();
 return filter_three(r1, r2, r3);
}

unsigned int read_sonar_left(void){
 unsigned int r1, r2, r3;
 r1 = read_sonar_left_raw();
 my_delay_ms(4);
 r2 = read_sonar_left_raw();
 my_delay_ms(4);
 r3 = read_sonar_left_raw();
 return filter_three(r1, r2, r3);
}



void main(void){
 unsigned int light_level;
 unsigned int dist_front, dist_mid, dist_left;
 unsigned char right_sensor, left_sensor;
 unsigned char zone = 1;
 unsigned int DARKNESS_THRESHOLD = 600;
 unsigned int pivot_timeout;

 unsigned char light_counter = 0;
 unsigned char finish_counter = 0;


 unsigned char kp = 4;
 unsigned char base_speed = 75;
 unsigned char DEADBAND = 3;
 int MAX_CORRECTION = 20;
 int p_error;
 int p_correction;
 int p_left_speed;
 int p_right_speed;

 int diff;
 unsigned char pivot_speed;

 ADCON1 = 0B10001110;
 TRISA = 0B00000111;
 TRISB = 0B11000001;
 TRISC = 0B00001000;
 TRISD = 0B11110000;

 PORTA = 0x00;
 PORTB = 0x00;
 PORTC = 0x00;
 PORTD = 0x00;

 T1CON = 0B00010000;
 CCPPWM_init();
 Move(0, 0);
 flag_down();


 OPTION_REG = OPTION_REG | 0B01000000;
 INTCON = 0B10010000;

 while(start_flag == 0){
 }

 INTCON = INTCON & 0B11101101;

 OPTION_REG = 0B11000111;
 TMR0 = 248;
 ms_counter = 0;
 INTCON = INTCON & 0B11111011;
 INTCON = INTCON | 0B00100000;

 while(ms_counter < 3000){
 }

 INTCON = INTCON & 0B11011111;
 INTCON = INTCON & 0B11111011;




 while(1){
 unsigned int i = 0;


 if(zone == 4){
 Move(0, 0);
 for(i; i < 1500; i++){
 asm nop;
 }
 flag_up();
 while(1){
 PORTB = PORTB | 0B00100000;
 my_delay_ms(2);
 PORTB = PORTB & 0B11011111;
 my_delay_ms(18);
 }
 }


 if(zone == 1 || zone == 2){
 light_level = read_LDR();

 if(zone == 1 && light_level > DARKNESS_THRESHOLD){
 zone = 2;
 PORTD = PORTD | 0B00001000;
 light_counter = 0;
 Move(0, 0);
 }
 else if(zone == 2){
 if(light_level < DARKNESS_THRESHOLD){
 light_counter++;
 if(light_counter >= 5){
 zone = 3;
 PORTD = PORTD & 0B11110111;
 light_counter = 0;
 Move(60, 60);
 my_delay_ms(350);
 Move(0, 0);
 my_delay_ms(60);
 }
 }
 else {
 light_counter = 0;
 }
 }
 }


 if(zone == 1){
 right_sensor = (PORTD & 0B00010000);
 left_sensor = (PORTD & 0B00100000);

 if(right_sensor && left_sensor){

 Move(50, 50);
 my_delay_ms(15);
 right_sensor = (PORTD & 0B00010000);
 left_sensor = (PORTD & 0B00100000);

 if(right_sensor && left_sensor){
 Move(0, 0);
 my_delay_ms(40);

 Pivot_Left(50);


 pivot_timeout = 0;
 while( PORTD & 0B00010000 ){
 pivot_timeout++;
 if(pivot_timeout > 100000) break;
 }


 pivot_timeout = 0;
 while( !(PORTD & 0B00010000) ){
 pivot_timeout++;
 if(pivot_timeout > 200000) break;
 }

 Move(0, 0);
 my_delay_ms(40);

 Move(60, 60);
 my_delay_ms(90);
 }
 }
 else if(right_sensor && !left_sensor){
 Move(80, 0);
 }
 else if(left_sensor && !right_sensor){
 Move(0, 80);
 }
 else {
 Move(60, 60);
 }
 }


 else if(zone == 2){
 right_sensor = (PORTD & 0B00010000);
 left_sensor = (PORTD & 0B00100000);

 if(right_sensor && !left_sensor){
 Move(70, 20);
 }
 else if(left_sensor && !right_sensor){
 Move(20, 70);
 }
 else {
 Move(70, 70);
 }
 }


 else if(zone == 3){


 right_sensor = (PORTD & 0B00010000);
 left_sensor = (PORTD & 0B00100000);

 if(right_sensor && left_sensor){
 finish_counter++;
 if(finish_counter >= 5){
 zone = 4;
 continue;
 }
 }
 else {
 finish_counter = 0;
 }


 dist_front = read_sonar_front_raw();
 if(dist_front != 999 && dist_front < 17){
 dist_front = read_sonar_front();
 }


 if(dist_front != 999 && dist_front < 22){
 Move(0, 0);
 my_delay_ms(180);


 dist_mid = read_sonar_mid();
 dist_left = read_sonar_left();


 if(dist_left > dist_mid){
 Pivot_Left(120);
 }
 else {
 Pivot_Right(120);
 }



 pivot_timeout = 0;
 while(pivot_timeout < 30){
 dist_front = read_sonar_front_raw();

 if(dist_front == 999 || dist_front > 30){
 break;
 }

 my_delay_ms(25);
 pivot_timeout++;
 }

 Move(0, 0);
 my_delay_ms(50);
 }


 else {

 dist_front = read_sonar_front();

 if(dist_front == 999 || dist_front > 50){
 base_speed = 75;
 }
 else if(dist_front > 30){
 base_speed = 55;
 }
 else if(dist_front >= 22){
 base_speed = 40;
 }
 else {
 continue;
 }


 dist_mid = read_sonar_mid();
 dist_left = read_sonar_left();

 if(dist_left == 999 || dist_left > 40) dist_left = 40;
 if(dist_mid == 999 || dist_mid > 40) dist_mid = 40;

 p_error = (int)dist_left - (int)dist_mid;


 if(p_error < (int)DEADBAND && p_error > -(int)DEADBAND){
 p_error = 0;
 }
 else {
 if(base_speed >= 30) {
 base_speed = base_speed - 10;
 }
 }


 p_correction = (int)kp * p_error;

 if(p_correction > MAX_CORRECTION) p_correction = MAX_CORRECTION;
 if(p_correction < -MAX_CORRECTION) p_correction = -MAX_CORRECTION;

 p_left_speed = (int)base_speed - p_correction;
 p_right_speed = (int)base_speed + p_correction;


 if(p_left_speed > 90) p_left_speed = 90;
 if(p_left_speed < 25) p_left_speed = 25;
 if(p_right_speed > 90) p_right_speed = 90;
 if(p_right_speed < 25) p_right_speed = 25;

 Move((unsigned char)p_left_speed, (unsigned char)p_right_speed);
 }
 }
 }
}
