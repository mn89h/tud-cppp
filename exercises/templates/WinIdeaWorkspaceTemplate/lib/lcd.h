#ifndef LCD_H
#define LCD_H

#include <stdio.h>
#include <stdlib.h>
#include <string.h>
#include <time.h>
#include "mcu.h"
#include "pdl_header.h"
#include "registers.h"
#include "pins.h"
#include "analog.h"



#define	BLACK   0x0000
#define	BLUE    0x001F
#define	RED     0xF800
#define	GREEN   0x07E0
#define CYAN    0x07FF
#define MAGENTA 0xF81F
#define YELLOW  0xFFE0
#define WHITE   0xFFFF

#define WIDTH   480
#define HEIGHT  320

struct TouchPoint{
  uint16_t x;
  uint16_t y;
  uint16_t z;
} touchPoint;  

void delay(int n);
void writeStrobe();
void write8(char d);
void write32(char r, long d);
void writeRegisterPair(char aH, char aL, int d);
void writeRegister8(char a, char d);
void setAddrWindow(int x1, int y1, int x2, int y2);
void init();
void reset();
void setupLCD();
void setLR(void);
void flood(int color, long len);

#endif /* LCD_H */