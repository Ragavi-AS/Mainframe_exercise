       IDENTIFICATION DIVISION.
       PROGRAM-ID. Q4-FEE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-BALANCE PIC 9(7).
       01 WS-MINIMUM PIC 9(7).
       01 WS-FEE PIC 9(7).
       01 WS-RESULT PIC 9(8).
       PROCEDURE DIVISION.
           DISPLAY "ENTER CURRENT BALANCE:".
           ACCEPT WS-BALANCE.
           DISPLAY "ENTER MINIMUM BALANCE:".
           ACCEPT WS-MINIMUM.
           DISPLAY "ENTER MAINTENANCE FEE:".
           ACCEPT WS-FEE.
           IF WS-BALANCE < WS-MINIMUM
               IF WS-BALANCE >= WS-FEE
                   COMPUTE WS-RESULT = WS-BALANCE - WS-FEE
                   DISPLAY "UPDATED BALANCE: " WS-RESULT
               ELSE
                   DISPLAY "FEE CANNOT BE COLLECTED"
               END-IF
           ELSE
               DISPLAY "UPDATED BALANCE: " WS-BALANCE
           END-IF.
           STOP RUN.
       