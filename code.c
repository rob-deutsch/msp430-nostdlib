#include <msp430.h>


void main(void) {
    WDTCTL = WDTPW + WDTHOLD;

    P1DIR=BIT6;
    P1OUT=BIT6;

    while(1);
}