       IDENTIFICATION DIVISION.
       PROGRAM-ID. Q13-SCORE.
       DATA DIVISION.
       WORKING-STORAGE SECTION.
       01 WS-SCORE PIC 999.
       PROCEDURE DIVISION.
           DISPLAY "ENTER CREDIT SCORE:".
           ACCEPT WS-SCORE.
           EVALUATE TRUE
               WHEN WS-SCORE < 300 OR WS-SCORE > 850
                   DISPLAY "INVALID SCORE"
               WHEN WS-SCORE <= 579
                   DISPLAY "POOR"
               WHEN WS-SCORE <= 669
                   DISPLAY "FAIR"
               WHEN WS-SCORE <= 739
                   DISPLAY "GOOD"
               WHEN WS-SCORE <= 799
                   DISPLAY "VERY GOOD"
               WHEN OTHER
                   DISPLAY "EXCELLENT"
           END-EVALUATE.
           STOP RUN.
       