       IDENTIFICATION DIVISION.
       PROGRAM-ID. Q2-ATM.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-BALANCE PIC 9(7).
       01 WS-WITHDRAW PIC 9(7).
       01 WS-REMAIN PIC Z(8).
       PROCEDURE DIVISION.
           DISPLAY "ENTER BALANCE:".
           ACCEPT WS-BALANCE.
           DISPLAY "ENTER WITHDRAWAL AMOUNT:".
           ACCEPT WS-WITHDRAW.
           IF WS-WITHDRAW <= 0
               DISPLAY "INVALID AMOUNT"
           ELSE
               IF WS-WITHDRAW > WS-BALANCE
                   DISPLAY "INSUFFICIENT FUNDS"
               ELSE
                  COMPUTE WS-REMAIN = WS-BALANCE - WS-WITHDRAW
                  DISPLAY "REMAINING BALANCE: " FUNCTION TRIM(WS-REMAIN)
                
               END-IF
           END-IF.
           STOP RUN.
       