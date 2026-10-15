       IDENTIFICATION DIVISION.
       PROGRAM-ID. Q5-TOTAL.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-N PIC 999.
       01 WS-I PIC 999.
       01 WS-AMOUNT PIC 9(7).
       01 WS-TOTAL PIC 9(10) VALUE 0.
       01 WS-INVALID PIC X VALUE "N".
       PROCEDURE DIVISION.
           DISPLAY "ENTER NUMBER OF TRANSACTIONS:".
           ACCEPT WS-N.
           PERFORM VARYING WS-I FROM 1 BY 1 UNTIL WS-I > WS-N
               DISPLAY "ENTER TRANSACTION AMOUNT:"
               ACCEPT WS-AMOUNT
               IF WS-AMOUNT < 0
                   MOVE "Y" TO WS-INVALID
               ELSE
                   ADD WS-AMOUNT TO WS-TOTAL
               END-IF
           END-PERFORM.
           IF WS-INVALID = "Y"
               DISPLAY "INVALID TRANSACTION"
           ELSE
               DISPLAY "TOTAL: " WS-TOTAL
           END-IF.
           STOP RUN.