using System;
using System.Collections.Generic;
using System.Linq;
using System.Text;

namespace CommTest
{
    public class DOSpacket
    {
        public static byte DOSpacketPut(byte header, params byte[] payload) /* Transmit packet to DOSonCHIP */
        /*
           Input:   header  : packet header byte
                    payload : pointer to memory buffer containing the payload
           Returns: 0|error
           Note:    the error/non-error result is saved for error diagnostics; the error detail parameter is cleared
        */
        {
            byte err;
            uint len;

            //   DOS_PORT_ENABLE;                                /* enable DOSonCHIP communications port */

            err = DOSport_UART.DOSportGetNotBusy();

            if (err == DOSprotocol.DOS_HANDSHAKE_GO)                    /* need DOS_HANDSHAKE_GO from DOSonCHIP to send packet */
            {
                len = 0;                                     /* assume error: no packet payload */

                DOSport_UART.DOSportPutByte(header);                     /* send packet header */

                /* Set packet payload length */
                switch (header)
                {
                    case DOSprotocol.DOS_HANDSHAKE_PAK_NEXT:
                        /* len = DOS_PACKET_LENGTH_PAYLOAD_HANDSHAKE; */
                        /* len = 0; */
                        break;
                    case DOSprotocol.DOS_HANDSHAKE_PAK_ABORT:
                        /* len = DOS_PACKET_LENGTH_PAYLOAD_HANDSHAKE; */
                        /* len = 0; */
                        break;
                    case DOSprotocol.DOS_DATA_NAME:
                        len = DOSfileAPI.DOSpacketPayloadLengthName;      /* current packet payload length */
                        break;
                    case DOSprotocol.DOS_DATA_BLOCK:
                        len = DOSfileAPI.DOSpacketPayloadLengthBlock;     /* current packet payload length */
                        break;
                    default:
                        /* len = DOS_PACKET_LENGTH_PAYLOAD_CMDRES; */
                        /* Send using global variables (ignore "payload" pointer) */
                        DOSport_UART.DOSportPutByte(DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0]);
                        DOSport_UART.DOSportPutByte(DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1]);
                        DOSport_UART.DOSportPutByte(DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2]);
                        DOSport_UART.DOSportPutByte(DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3]);
                        /* len = 0; */
                        break;
                }

                /* Transfer payload */
                while (len > 0)
                {
                    DOSport_UART.DOSportPutByte(payload[len]);
                    len--;
                }

                /* No footer */

                err = 0;                                     /* no error */
            }

            DOSport_UART.DOSportFlushQ();                               /* Make sure transmit/receive queue is clear */

            //DOS_PORT_DISABLE;                               /* disable DOSonCHIP communications port */

            /* Save error for diagnostics */
            DOSfileAPI.DOScommandResponse[0] = err;                    /* packet header = 0|error */
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0; /* Clear error detail */
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = 0;

            return (DOSfileAPI.DOScommandResponse[0]);
        }

        /*******************************************************************************/
        public static void DOSpacketPutBlock(byte[] payload)    /* Transmit DOS_DATA_BLOCK packet to DOSonCHIP */
        /*
           Input:   payload : pointer to memory buffer containing the payload
           Returns: void
        */
        {
            uint len;

            //DOS_PORT_ENABLE;                                /* enable DOSonCHIP communications port */

            DOSport_UART.DOSportPutByte(DOSprotocol.DOS_DATA_BLOCK);               /* send packet header */

            len = DOSfileAPI.DOSpacketPayloadLengthBlock;              /* current packet payload length */

            /* Transfer payload */
            while (len > 0)
            {
                DOSport_UART.DOSportPutByte(payload[len]);
                len--;
            }

            /* No footer */

            DOSport_UART.DOSportFlushQ();                               /* Make sure transmit/receive queue is clear */

            //DOS_PORT_DISABLE;                               /* disable DOSonCHIP communications port */
        }

        /*******************************************************************************/
        public static byte DOSpacketGet(params byte[] payload) /* Receive packet from DOSonCHIP */
        /*
           Input:   payload : pointer to memory buffer to place the received payload
           Returns: packet header byte | error
           Note:    if command or response, payload is placed into global array
        */
        {
            uint len = 0;
            byte response = 0;                     /* assume no error */

            /* Clear error detail */
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = 0;

            //DOS_PORT_ENABLE;                                /* enable DOSonCHIP communications port */

            DOSfileAPI.DOScommandResponse[0] = DOSport_UART.DOSportGetNotBusy();   /* get packet header */
            response = DOSfileAPI.DOScommandResponse[0];
            switch (DOSfileAPI.DOScommandResponse[0])
            {
                case DOSprotocol.DOS_HANDSHAKE_WAIT:
                    /* DOScommandResponse[0] = DOS_HOST_ERROR_TIMEOUT; */
                    response = DOSfileAPI.DOS_HOST_ERROR_TIMEOUT;
                    /* len = 0; */
                    break;
                case DOSprotocol.DOS_HANDSHAKE_OFF:
                    /* DOScommandResponse[0] = DOS_HOST_COMMUNICATION_ERROR; */
                    response = DOSfileAPI.DOS_HOST_COMMUNICATION_ERROR;
                    /* len = 0; */
                    break;
                case DOSprotocol.DOS_DATA_NAME:
                    len = DOSfileAPI.DOSpacketPayloadLengthName;         /* current packet payload length */
                    break;
                case DOSprotocol.DOS_DATA_BLOCK:
                    len = DOSfileAPI.DOSpacketPayloadLengthBlock;        /* current packet payload length */
                    break;
                default:
                    /* if command/response packet, save for error diagnostics */
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = DOSport_UART.DOSportGetByte();
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = DOSport_UART.DOSportGetByte();
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = DOSport_UART.DOSportGetByte();
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = DOSport_UART.DOSportGetByte();
                    /* len = 0; */
                    break;
            }

            /* Transfer payload, if any */
            while (len > 0)
            {
                payload[len] = DOSport_UART.DOSportGetByte();
                len--;
            }

            /* No footer */

            //DOS_PORT_DISABLE;                               /* disable DOSonCHIP communications port */

            return (response);                              /* return packet header | error */
        }

        /*******************************************************************************/
        public static byte DOSpacketGetResponse() /* Receive a response packet from DOSonCHIP */
        /*
           Returns: packet header byte | error
           Note:    if response, payload is placed into global array
        */
        {
            uint len = 0;
            byte response = 0;                     /* assume no error */

            /* Clear error detail */
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = 0;
            DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = 0;

            //DOS_PORT_ENABLE;                                /* enable DOSonCHIP communications port */

            DOSfileAPI.DOScommandResponse[0] = DOSport_UART.DOSportGetNotBusy();   /* get packet header */
            response = DOSfileAPI.DOScommandResponse[0];
            switch (DOSfileAPI.DOScommandResponse[0])
            {
                case DOSprotocol.DOS_HANDSHAKE_GO:
                    /* len = 0; */
                    break;
                case DOSprotocol.DOS_HANDSHAKE_WAIT:
                    /* DOScommandResponse[0] = DOS_HOST_ERROR_TIMEOUT; */
                    response = DOSfileAPI.DOS_HOST_ERROR_TIMEOUT;
                    /* len = 0; */
                    break;
                case DOSprotocol.DOS_HANDSHAKE_OFF:
                    /* DOScommandResponse[0] = DOS_HOST_COMMUNICATION_ERROR; */
                    response = DOSfileAPI.DOS_HOST_COMMUNICATION_ERROR;
                    /* len = 0; */
                    break;
                case DOSprotocol.DOS_DATA_NAME:
                    response = DOSprotocol.DOS_RES_INVALID_PACKET_TYPE;
                    len = DOSfileAPI.DOSpacketPayloadLengthName;         /* current packet payload length */
                    break;
                case DOSprotocol.DOS_DATA_BLOCK:
                    response = DOSprotocol.DOS_RES_INVALID_PACKET_TYPE;
                    len = DOSfileAPI.DOSpacketPayloadLengthBlock;        /* current packet payload length */
                    break;
                default:
                    /* get response packet payload */
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 0] = DOSport_UART.DOSportGetByte();
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 1] = DOSport_UART.DOSportGetByte();
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 2] = DOSport_UART.DOSportGetByte();
                    DOSfileAPI.DOScommandResponse[DOSprotocol.DOS_PACKET_LENGTH_HEADER + 3] = DOSport_UART.DOSportGetByte();
                    /* len = 0; */
                    break;
            }

            /* Absorb improper payload from DOSonCHIP IC if improper data packet */
            while (len > 0)
            {
                DOSport_UART.DOSportGetByte();
                len--;
            }

            /* No footer */

            //DOS_PORT_DISABLE;                               /* disable DOSonCHIP communications port */

            return (response);                              /* return packet header | error */
        }

    }
}
