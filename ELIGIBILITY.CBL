       IDENTIFICATION DIVISION.
       PROGRAM-ID. Q9-ELIGIBILITY.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-AGE PIC 999.
       01 WS-VERIFY PIC X.
       PROCEDURE DIVISION.
           DISPLAY "ENTER CUSTOMER AGE:".
           ACCEPT WS-AGE.
           DISPLAY "IDENTITY VERIFIED? (Y/N):".
           ACCEPT WS-VERIFY.
           IF WS-AGE >= 18 AND
              (WS-VERIFY = "Y" OR WS-VERIFY = "y")
               DISPLAY "ELIGIBLE"
           ELSE
               DISPLAY "NOT ELIGIBLE"
           END-IF.
           STOP RUN.
       