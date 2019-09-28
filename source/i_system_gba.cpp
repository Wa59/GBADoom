#include <stdarg.h>
#include <stdio.h>
#include <cstring>

#ifdef __arm__

extern "C"
{
    #include "doomdef.h"
    #include "doomtype.h"
    #include "d_main.h"
    #include "d_event.h"

    #include "global_data.h"
}

#include "i_system_e32.h"

#include "lprintf.h"

#include <gba.h>
#include <gba_input.h>
#include <gba_timers.h>

#define DCNT_PAGE 0x0010

#define VID_PAGE1 VRAM
#define VID_PAGE2 0x600A000

#define TM_FREQ_1024 0x0003
#define TM_ENABLE 0x0080
#define TM_CASCADE 0x0004
#define TM_FREQ_1024 0x0003
#define TM_FREQ_256 0x0002


//**************************************************************************************

unsigned int vid_width = 0;
unsigned int vid_height = 0;

unsigned int screen_width = 0;
unsigned int screen_height = 0;

unsigned int y_pitch = 0;

//**************************************************************************************

void I_InitScreen_e32()
{
    //Gives 480px on a 5(mx) and 320px on a Revo.
    vid_width = 120;

    vid_height = screen_height = 160;

    // the vblank interrupt must be enabled for VBlankIntrWait() to work
    // since the default dispatcher handles the bios flags no vblank handler
    // is required
    irqInit();
    irqEnable(IRQ_VBLANK);

    consoleDemoInit();

    REG_TM2CNT_L= -1872;     // 1872 ticks = 1/35 secs
    REG_TM2CNT_H = TM_FREQ_256 | TM_ENABLE;       // we're using the 256 cycle timer

    // cascade into tm3
    REG_TM3CNT_H = TM_ENABLE | TM_CASCADE;
}

//**************************************************************************************

void I_BlitScreenBmp_e32()
{

}

//**************************************************************************************

void I_StartWServEvents_e32()
{

}

//**************************************************************************************

void I_PollWServEvents_e32()
{
    scanKeys();

    u16 key_down = keysDown();

    event_t ev;

    if(key_down & KEY_A)    ev.data1 = KEYD_ENTER;
    if(key_down & KEY_UP)   ev.data1 = KEYD_UPARROW;
    if(key_down & KEY_DOWN) ev.data1 = KEYD_DOWNARROW;
    if(key_down & KEY_LEFT) ev.data1 = KEYD_LEFTARROW;
    if(key_down & KEY_RIGHT)ev.data1 = KEYD_RIGHTARROW;
    if(key_down & KEY_START)ev.data1 = KEYD_ESCAPE;


    ev.type = ev_keydown;

    if(ev.data1 != 0)
        D_PostEvent(&ev);

    ev.data1 = 0;

    u16 key_up = keysUp();

    if(key_up & KEY_A)    ev.data1 = KEYD_ENTER;
    if(key_up & KEY_UP)   ev.data1 = KEYD_UPARROW;
    if(key_up & KEY_DOWN) ev.data1 = KEYD_DOWNARROW;
    if(key_up & KEY_LEFT) ev.data1 = KEYD_LEFTARROW;
    if(key_up & KEY_RIGHT)ev.data1 = KEYD_RIGHTARROW;
    if(key_up & KEY_START)ev.data1 = KEYD_ESCAPE;

    ev.type = ev_keyup;

    if(ev.data1 != 0)
        D_PostEvent(&ev);
}

//**************************************************************************************

void I_ClearWindow_e32()
{

}

//**************************************************************************************

unsigned short* I_GetBackBuffer()
{
    if(REG_DISPCNT & DCNT_PAGE)
        return (unsigned short*)VID_PAGE1;

    return (unsigned short*)VID_PAGE2;
}

//**************************************************************************************

void I_CreateWindow_e32()
{
    SetMode(MODE_4 | BG_ALL_ON);
}

//**************************************************************************************

void I_CreateBackBuffer_e32()
{
    I_CreateWindow_e32();
}

//**************************************************************************************

void I_FinishUpdate_e32(const byte* srcBuffer, const byte* pallete, const unsigned int width, const unsigned int height)
{
    VBlankIntrWait();

    REG_DISPCNT ^= DCNT_PAGE;
}

//**************************************************************************************

void I_SetPallete_e32(const byte* pallete)
{
    unsigned short* pal_ram = (unsigned short*)0x5000000;

    unsigned short pal_temp[256];

    for(int i = 0; i< 256; i++)
    {
        pal_temp[i] = RGB8(pallete[3*i],pallete[(3*i)+1], pallete[(3*i)+2]);
    }

    VBlankIntrWait();

    memcpy(pal_ram, pal_temp, 256*2);
}

//**************************************************************************************

int I_GetVideoWidth_e32()
{
    return vid_width;
}

//**************************************************************************************

int I_GetVideoHeight_e32()
{
    return vid_height;
}

//**************************************************************************************

int I_GetTime_e32(void)
{
    unsigned long thistimereply;

    thistimereply = REG_TM3CNT;

    /* Fix for time problem */
    if (!_g->basetime)
    {
        _g->basetime = thistimereply;
        thistimereply = 0;
    }
    else
    {
        thistimereply -= _g->basetime;
    }


    if (thistimereply < _g->lasttimereply)
        thistimereply = _g->lasttimereply;

    return (_g->lasttimereply = thistimereply);
}

//**************************************************************************************

void I_ProcessKeyEvents()
{
    I_PollWServEvents_e32();
}

//**************************************************************************************

#define MAX_MESSAGE_SIZE 1024

void I_Error (const char *error, ...)
{
    consoleDemoInit();

    char msg[MAX_MESSAGE_SIZE];

    va_list v;
    va_start(v, error);

    vsprintf(msg, error, v);

    va_end(v);

    printf("%s", msg);

    while(true)
    {
        VBlankIntrWait();
    }
}

//**************************************************************************************

void I_Quit_e32()
{

}

//**************************************************************************************

#endif