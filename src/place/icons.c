#include <u.h>
#include <libc.h>
#include <libg.h>


Cursor arrow={
	{0, 0},
	{0xFF, 0xE0, 0xFF, 0xE0, 0xFF, 0xC0, 0xFF, 0x00,
	 0xFF, 0x00, 0xFF, 0x80, 0xFF, 0xC0, 0xFF, 0xE0,
	 0xE7, 0xF0, 0xE3, 0xF8, 0xC1, 0xFC, 0x00, 0xFE,
	 0x00, 0x7F, 0x00, 0x3E, 0x00, 0x1C, 0x00, 0x08,},
	{0x00, 0x00, 0x7F, 0xC0, 0x7F, 0x00, 0x7C, 0x00,
	 0x7E, 0x00, 0x7F, 0x00, 0x6F, 0x80, 0x67, 0xC0,
	 0x43, 0xE0, 0x41, 0xF0, 0x00, 0xF8, 0x00, 0x7C,
	 0x00, 0x3E, 0x00, 0x1C, 0x00, 0x08, 0x00, 0x00,}
};
Cursor bullseye={
	{-7, -7},
	{0x1F, 0xF8, 0x3F, 0xFC, 0x7F, 0xFE, 0xFB, 0xDF,
	 0xF3, 0xCF, 0xE3, 0xC7, 0xFF, 0xFF, 0xFF, 0xFF,
	 0xFF, 0xFF, 0xFF, 0xFF, 0xE3, 0xC7, 0xF3, 0xCF,
	 0x7B, 0xDF, 0x7F, 0xFE, 0x3F, 0xFC, 0x1F, 0xF8,},
	{0x00, 0x00, 0x0F, 0xF0, 0x31, 0x8C, 0x21, 0x84,
	 0x41, 0x82, 0x41, 0x82, 0x41, 0x82, 0x7F, 0xFE,
	 0x7F, 0xFE, 0x41, 0x82, 0x41, 0x82, 0x41, 0x82,
	 0x21, 0x84, 0x31, 0x8C, 0x0F, 0xF0, 0x00, 0x00,}
};
Cursor coffeecup={
	{-7, -7},
	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,},
	{0x01, 0x00, 0x00, 0xE0, 0x00, 0x10, 0x03, 0xE0,
	 0x04, 0x00, 0x0F, 0xE0, 0x12, 0x3C, 0x1F, 0xE2,
	 0x10, 0x1A, 0x10, 0x1A, 0x10, 0x02, 0x10, 0x3C,
	 0x18, 0x10, 0x6F, 0xEC, 0x40, 0x04, 0x3F, 0xF8,}
};
Cursor blank={
	{-7, -7},
	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,},
	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,}
};
Cursor sweep={
	{-7, -7},
	{0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xE0, 0x07,
	 0xE0, 0x07, 0xE0, 0x07, 0xE3, 0xF7, 0xE3, 0xF7,
	 0xE3, 0xE7, 0xE3, 0xF7, 0xE3, 0xFF, 0xE3, 0x7F,
	 0xE0, 0x3F, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,},
	{0x00, 0x00, 0x7F, 0xFE, 0x40, 0x02, 0x40, 0x02,
	 0x40, 0x02, 0x40, 0x02, 0x40, 0x02, 0x41, 0xE2,
	 0x41, 0xC2, 0x41, 0xE2, 0x41, 0x72, 0x40, 0x38,
	 0x40, 0x1C, 0x40, 0x0E, 0x7F, 0xE6, 0x00, 0x00,}
};
Cursor deadmouse={
	{-7, -7},
	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,},
	{0x00, 0x00, 0x01, 0x14, 0xA2, 0x08, 0x41, 0x00,
	 0x00, 0x00, 0x00, 0x08, 0x00, 0x04, 0x00, 0x82,
	 0x04, 0x41, 0xFF, 0xE1, 0x5F, 0xF1, 0x3F, 0xFE, 
	 0x17, 0xF0, 0x03, 0xE0, 0x00, 0x00, 0x00, 0x00,}
};
Cursor lockarrow={
	{-7, -7},
	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,},
	{0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	 0x00, 0x00, 0x00, 0x00, 0x0F, 0xC0, 0x0F, 0xC0,
	 0x03, 0xC0, 0x07, 0xC0, 0x0E, 0xC0, 0x1C, 0xC0,
	 0x38, 0x00, 0x70, 0x00, 0xE0, 0xDB, 0xC0, 0xDB,}
};


uchar greybits[] = {
	0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55,
	0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55,
	0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55,
	0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55
};

uchar blackbits[] = {
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
};

uchar darkgreybits[] = {
	0xDD, 0xDD, 0x77, 0x77, 0xDD, 0xDD, 0x77, 0x77,
	0xDD, 0xDD, 0x77, 0x77, 0xDD, 0xDD, 0x77, 0x77,
	0xDD, 0xDD, 0x77, 0x77, 0xDD, 0xDD, 0x77, 0x77,
	0xDD, 0xDD, 0x77, 0x77, 0xDD, 0xDD, 0x77, 0x77
};

uchar colourbits[] = {
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF,
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 
	0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 0xFF, 

	0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA, 
	0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA,
	0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA, 
	0x55, 0x55, 0xAA, 0xAA, 0x55, 0x55, 0xAA, 0xAA,

	0x11, 0x11, 0x44, 0x44, 0x11, 0x11, 0x44, 0x44, 
	0x11, 0x11, 0x44, 0x44, 0x11, 0x11, 0x44, 0x44,
	0x11, 0x11, 0x44, 0x44, 0x11, 0x11, 0x44, 0x44, 
	0x11, 0x11, 0x44, 0x44, 0x11, 0x11, 0x44, 0x44,

	0x01, 0x01, 0x02, 0x02, 0x04, 0x04, 0x08, 0x08, 
	0x10, 0x10, 0x20, 0x20, 0x40, 0x40, 0x80, 0x80,
	0x01, 0x01, 0x02, 0x02, 0x04, 0x04, 0x08, 0x08, 
	0x10, 0x10, 0x20, 0x20, 0x40, 0x40, 0x80, 0x80,

	0x80, 0x80, 0x40, 0x40, 0x20, 0x20, 0x10, 0x10, 
	0x08, 0x08, 0x04, 0x04, 0x02, 0x02, 0x01, 0x01,
	0x80, 0x80, 0x40, 0x40, 0x20, 0x20, 0x10, 0x10, 
	0x08, 0x08, 0x04, 0x04, 0x02, 0x02, 0x01, 0x01,

	0x10, 0x00, 0x20, 0x00, 0x40, 0x00, 0x80, 0x00, 
	0x00, 0x01, 0x00, 0x02, 0x00, 0x04, 0x00, 0x08,
	0x00, 0x10, 0x00, 0x20, 0x00, 0x40, 0x00, 0x80, 
	0x01, 0x00, 0x02, 0x00, 0x04, 0x00, 0x08, 0x00, 

	0x00, 0x08, 0x00, 0x04, 0x00, 0x02, 0x00, 0x01, 
	0x80, 0x00, 0x40, 0x00, 0x20, 0x00, 0x10, 0x00,
	0x08, 0x00, 0x04, 0x00, 0x02, 0x00, 0x01, 0x00, 
	0x00, 0x80, 0x00, 0x40, 0x00, 0x20, 0x00, 0x10,

	0x01, 0x01, 0x01, 0x01, 0x02, 0x02, 0x02, 0x02, 
	0x04, 0x04, 0x04, 0x04, 0x08, 0x08, 0x08, 0x08, 
	0x10, 0x10, 0x10, 0x10, 0x20, 0x20, 0x20, 0x20, 
	0x40, 0x40, 0x40, 0x40, 0x80, 0x80, 0x80, 0x80, 

	0x80, 0x80, 0x80, 0x80, 0x40, 0x40, 0x40, 0x40, 
	0x20, 0x20, 0x20, 0x20, 0x10, 0x10, 0x10, 0x10, 
	0x08, 0x08, 0x08, 0x08, 0x04, 0x04, 0x04, 0x04, 
	0x02, 0x02, 0x02, 0x02, 0x01, 0x01, 0x01, 0x01, 
};
int ncolours = sizeof(colourbits)/sizeof(colourbits[1]);

static uchar vccpinbits[] =
{
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x88, 0x00,
	0x50, 0x00, 0x20, 0x00, 0x0E, 0x00, 0x10, 0x00,
	0x0E, 0x00, 0x01, 0xC0, 0x02, 0x00, 0x01, 0xC0,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

static uchar ncpinbits[] =
{
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x07, 0xE0, 0x04, 0x20, 0x04, 0x20,
	0x04, 0x20, 0x04, 0x20, 0x07, 0xE0, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

static uchar sigpinbits[] =
{
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00,
	0x00, 0x00, 0x07, 0xE0, 0x07, 0xE0, 0x07, 0xE0,
	0x07, 0xE0, 0x07, 0xE0, 0x07, 0xE0, 0x00, 0x00,
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

static uchar gndpinbits[] =
{
	0x00, 0x00, 0x00, 0x00, 0x00, 0x00, 0x01, 0x80,
	0x01, 0x80, 0x01, 0x80, 0x01, 0x80, 0x01, 0x80,
	0x1F, 0xF8, 0x0F, 0xF0, 0x07, 0xE0, 0x03, 0xC0,
	0x01, 0x80, 0x00, 0x00, 0x00, 0x00, 0x00, 0x00
};

Bitmap  *black;
Bitmap	*grey;
Bitmap	*darkgrey;
Bitmap	*colour;
Bitmap  *gndpin;
Bitmap  *sigpin;
Bitmap  *vccpin;
Bitmap  *ncpin;

void iconinit(void){
	ncpin = balloc(Rect(0, 0, 16, 16),0);
	wrbitmap(ncpin, 0, 16, ncpinbits);
	sigpin = balloc(Rect(0, 0, 16, 16),0);
	wrbitmap(sigpin, 0, 16, sigpinbits);
	gndpin = balloc(Rect(0, 0, 16, 16),0);
	wrbitmap(gndpin, 0, 16, gndpinbits);
	vccpin = balloc(Rect(0, 0, 16, 16),0);
	wrbitmap(vccpin, 0, 16, vccpinbits);
	darkgrey = balloc(Rect(0, 0, 16, 16), 0);
	wrbitmap(darkgrey, 0, 16, darkgreybits);
	grey = balloc(Rect(0, 0, 16, 16), 0);
	wrbitmap(grey, 0, 16, darkgreybits);
	colour = balloc(Rect(0, 0, 16, 16), 0);
	wrbitmap(colour, 0, 16, colourbits);
	black = balloc(Rect(0, 0, 16, 16), 0);
	wrbitmap(black, 0, 16, blackbits);
}
