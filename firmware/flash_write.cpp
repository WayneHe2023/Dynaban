#include <flash.h>
#include "flash_write.h"
#include <wirish/wirish.h>

#define FLASH_KEY1     0x45670123
#define FLASH_KEY2     0xCDEF89AB

void flash_unlock()
{
    FLASH_BASE->KEYR = FLASH_KEY1;
    FLASH_BASE->KEYR = FLASH_KEY2;
}

void flash_lock()
{
    FLASH_BASE->CR = FLASH_CR_LOCK;
}

bool flash_erase_page(unsigned int pageAddr)
{
    FLASH_BASE->CR = FLASH_CR_PER;

    while (FLASH_BASE->SR & FLASH_SR_BSY);
    FLASH_BASE->AR = pageAddr;
    FLASH_BASE->CR = FLASH_CR_STRT & FLASH_CR_PER;
    while (FLASH_BASE->SR & FLASH_SR_BSY);

    FLASH_BASE->CR = 0;

    return true;
}

/*
 * Keeping this version of flash erase just in case.
 * It's closer to what the datasheets says, but has not been tested as much as the above version.
 */
//bool flash_erase_page(unsigned int pageAddr)
//{
//    while (FLASH_BASE->SR & FLASH_SR_BSY);
//    FLASH_BASE->CR = FLASH_CR_PER;
//    FLASH_BASE->AR = pageAddr;
//    FLASH_BASE->CR = FLASH_CR_STRT;
//    while (FLASH_BASE->SR & FLASH_SR_BSY);
//
//    FLASH_BASE->CR = 0;
//
//    return true;
//}

bool flash_write_word(unsigned int addr, unsigned int word)
{
    volatile unsigned short *flashAddr = (volatile unsigned short*)addr;
    volatile unsigned int lhWord = (volatile unsigned int)word & 0x0000FFFF;
    volatile unsigned int hhWord = ((volatile unsigned int)word & 0xFFFF0000)>>16;

    unsigned int rwmVal = FLASH_BASE->CR;
    FLASH_BASE->CR = FLASH_CR_PG;

    /* apparently we need not write to FLASH_AR and can
     *      simply do a native write of a half word */
    while (FLASH_BASE->SR & FLASH_SR_BSY);
    *(flashAddr+0x01) = (volatile unsigned short)hhWord;
    while (FLASH_BASE->SR & FLASH_SR_BSY);
    *(flashAddr) = (volatile unsigned short)lhWord;
    while (FLASH_BASE->SR & FLASH_SR_BSY);

    rwmVal &= 0xFFFFFFFE;
    FLASH_BASE->CR = rwmVal;

    /* verify the write */
    if (*(volatile unsigned int*)addr != word) {
    	digitalWrite(BOARD_TX_ENABLE, HIGH);
    	Serial1.println();
		Serial1.print("failed to write at : ");
		Serial1.print(addr);
		Serial1.println();
		Serial1.print("FLASH_BASE->SR = ");
		Serial1.println(FLASH_BASE->SR);
    	Serial1.waitDataToBeSent();
    	digitalWrite(BOARD_TX_ENABLE, LOW);
		digitalWrite(BOARD_TX_ENABLE, HIGH);

        return false;
    }

    return true;
}

void flash_write(unsigned int addr, void *data, unsigned int size)
{
    unsigned int n, i;
    unsigned char *cdata = (unsigned char*)data;

    flash_unlock();

    // for each page 
    for (n=0; n<size; n+=0x400) {
        // number of words to process
        unsigned int pageBytes = size-n;
        unsigned int pageWords = pageBytes >> 2;
        // if there is remaining data (when size is not a multiple of 4),
        // treat an extra word 
        if (pageBytes & 0x3) pageWords++;
        if (pageWords > 256) pageWords = 256;

		digitalWrite(BOARD_TX_ENABLE, HIGH);
		Serial1.println();
		Serial1.print("First KB =  ");
		Serial1.println(*(volatile unsigned char*)(addr+10));
		Serial1.print("(before erase) FLASH_BASE->SR = ");
		Serial1.println(FLASH_BASE->SR);
		Serial1.waitDataToBeSent();
		digitalWrite(BOARD_TX_ENABLE, LOW);

        flash_erase_page(addr+n);

		digitalWrite(BOARD_TX_ENABLE, HIGH);
		Serial1.println();
		Serial1.print("First KB =  ");
		Serial1.println(*(volatile unsigned char*)(addr+10));
		Serial1.print("(after erase) FLASH_BASE->SR = ");
		Serial1.println(FLASH_BASE->SR);
		Serial1.waitDataToBeSent();
		digitalWrite(BOARD_TX_ENABLE, LOW);

		for (i=0; i<pageWords; i++) {
        	flash_write_word(addr+n+i*4, *(unsigned int*)&cdata[n+i*4]);
        }
    }

    flash_lock();


}

void flash_read(unsigned int addr, void *data, unsigned int size)
{
    unsigned char *cdata = (unsigned char*)data;
    unsigned int i;

    for (i=0; i<size; i++) {
        cdata[i] = *(volatile unsigned char*)(addr+i);
    }
}
