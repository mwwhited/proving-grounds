using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommTest
{
    public static class DOSport_UART
    {
        public static byte SCON1 { get; set; }
        public static byte P2 { get; set; }
        public static byte SBUF1 { get; set; }

        public static bool TI1 { get { return (SCON1 & 0x02) == 0x02; } }           /* UART flag that previous byte has been transmitted */
        public static void TI1_CLR() { SCON1 &= 0xfd; }              /* UART clear flag */
        public static void TI1_SET() { SCON1 |= 0x02; }              /* UART set flag */
        public static bool RI1 { get { return (SCON1 & 0x01) == 0x01; } }              /* UART flag that byte has been received by */
        public static void RI1_CLR() { SCON1 &= (byte)(0xfe); }              /* UART clear flag */
        public static bool DOS_UART_RTS_BUSY // = P2 ^ 7;              /* P2.7 = CTS0 (open-drain input) */
        {
            get { return (P2 & (2 << 7)) == (2 << 7); }
            set {
                if (value)
                    P2 |= 0x80;
                else
                    P2 &= 0x7f;
            }
        }
        public static bool DOS_UART_CTS //= P2 ^ 6;              /* P2.6 = RTSO (push-pull output) */
        {
            get { return (P2 & (2 << 7)) == (2 << 7); }
            set {
                if (value)
                    P2 |= 0x40;
                else
                    P2 &= 0xbf;
            }
        }

        public static void DOS_PORT_ENABLE() { }                      /* stub */
        public static void DOS_PORT_DISABLE() { }                     /* stub */

        /*******************************************************************************
           Copyright 2008, 2009 Wearable Inc.; An Illinois, United States Corporation

           Licensed under the Apache License, Version 2.0 (the "License");
           you may not use this file except in compliance with the License.
           You may obtain a copy of the License at

               http://www.apache.org/licenses/LICENSE-2.0

           Unless required by applicable law or agreed to in writing, software
           distributed under the License is distributed on an "AS IS" BASIS,
           WITHOUT WARRANTIES OR CONDITIONS OF ANY KIND, either express or implied.
           See the License for the specific language governing permissions and
           limitations under the License.
        *******************************************************************************/
        /*******************************************************************************
           Name:        DOSonCHIP(TM) Physical Communications Port Definitions (UART)
           File Name:   DOSport_UART.c
           Description: UART Communications Subroutines (CPU Specific)
        *******************************************************************************/

        /******************************************************************************/
        public static byte DOSportGetNotBusy()             /* Wait for valid response byte */
        {
            byte response;

            /* skip DOS_HANDSHAKE_WAIT bytes */
            DOSportPutByte(DOSprotocol.DOS_HANDSHAKE_POLL);            /* Wake up DOSonCHIP */
            while ((response = DOSportGetByte()) == DOSprotocol.DOS_HANDSHAKE_WAIT) ;
            return response;
        }

        /*******************************************************************************/
        public static byte DOSportPutByte(byte txByte) /* Transmit byte to DOSonCHIP */
        {
            while (!TI1) ;                                   /* wait for previous byte to be transmitted */
            TI1_CLR();                                        /* manually clear transmit flag */
            /* while (DOS_UART_RTS_BUSY); */
            /* wait for DOSonCHIP to be ready to accept bytes */
            SBUF1 = txByte;                                 /* transmit byte to host */

            return 0;
        }

        /*******************************************************************************/
        public static byte DOSportGetByte()                /* Receive byte from DOSonCHIP */
        {
            ulong DOSflagTimeOut = 0xFFFFFFFF;

            /* DOS_UART_CTS = 0; */
            /* allow DOSonCHIP to send bytes to host */
            while (!RI1 && DOSflagTimeOut == 0)                  /* wait for byte to be received */
            {
                /* Wait loop time is CPU specific! */
                /* If available, use a timer interrupt to set DOSflagTimeOut */
                DOSflagTimeOut--;
            }
            RI1_CLR();                                        /* manually clear receive flag */
            /* DOS_UART_CTS = 1; */
            /* prevent DOSonCHIP from sending bytes to host */
            if (DOSflagTimeOut!=0) return DOSprotocol.DOS_HANDSHAKE_OFF;  /* if timeout, return no response */
            else return SBUF1;                              /* return UART byte */
        }

        /*******************************************************************************/
        public static void DOSportFlushQ()                          /* Wait until transmit/receive queue is empty */
        {
        }

        /*******************************************************************************/
        public static void DOSportInit()                            /* Initialize host port */
        {
            ulong DOSflagTimeOut;

            TI1_SET();                                        /* set initial state for DOSportPutByte */

            /* DOS_UART_CTS = 0; */
            /* allow DOSonCHIP to send bytes to host */
            do
            {
                /* send at least 2 carriage returns for DOSonCHIP autobaud routine */
                DOSportPutByte(0x0D);                       /* send first carriage return */

                DOSflagTimeOut = 0x0004FFFF;                 /* wait a bit for DOSonCHIP to process */
                while (DOSflagTimeOut-- != 0) ;

                DOSportPutByte(0x0D);                       /* send confirming carriage return */

                DOSflagTimeOut = 0xFFFF;                     /* wait for byte to be received */
                while (!RI1 && DOSflagTimeOut == 0)
                {
                    /* Wait loop time is CPU specific! */
                    /* If available, use a timer interrupt to set DOSflagTimeOut */
                    DOSflagTimeOut--;
                }
                RI1_CLR();                                     /* manually clear receive flag */
            } while (SBUF1 != DOSprotocol.DOS_RES_NOERROR);
            /* CTS = 1; */
            /* prevent DOSonCHIP from sending bytes to host */
        }

    }
}
