       IDENTIFICATION DIVISION.
       PROGRAM-ID. CHECKPOINT-RESTART.

       ENVIRONMENT DIVISION.
       INPUT-OUTPUT SECTION.
       FILE-CONTROL.

           SELECT INPUT-FILE
               ASSIGN TO "INPUT.DAT"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS INPUT-STATUS.

           SELECT CHECKPOINT-FILE
               ASSIGN TO "CHECKPT.DAT"
               ORGANIZATION IS LINE SEQUENTIAL
               FILE STATUS IS CHECKPOINT-STATUS.

       DATA DIVISION.
       FILE SECTION.

       FD INPUT-FILE.
       01 INPUT-RECORD PIC X(10).

       FD CHECKPOINT-FILE.
       01 CHECKPOINT-RECORD PIC X(10).

       WORKING-STORAGE SECTION.

       01 INPUT-STATUS PIC XX.
       01 CHECKPOINT-STATUS PIC XX.

       01 CHECKPOINT-VALUE PIC X(10).

       01 EOF-FLAG PIC X VALUE 'N'.
       01 FOUND-FLAG PIC X VALUE 'N'.
       01 START-FLAG PIC X VALUE 'N'.

       PROCEDURE DIVISION.

       MAIN-PARA.

      * READ CHECKPOINT FILE
           OPEN INPUT CHECKPOINT-FILE

           IF CHECKPOINT-STATUS NOT = "00"
               DISPLAY "ERROR: CANNOT OPEN CHECKPOINT FILE"
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

           READ CHECKPOINT-FILE

           IF CHECKPOINT-STATUS = "10"
               DISPLAY "ERROR: CHECKPOINT FILE IS EMPTY"
               CLOSE CHECKPOINT-FILE
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

           IF CHECKPOINT-STATUS NOT = "00"
               DISPLAY "ERROR: CHECKPOINT READ FAILED"
               CLOSE CHECKPOINT-FILE
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

           MOVE CHECKPOINT-RECORD TO CHECKPOINT-VALUE

           CLOSE CHECKPOINT-FILE

      * OPEN INPUT DATASET
           OPEN INPUT INPUT-FILE

           IF INPUT-STATUS NOT = "00"
               DISPLAY "ERROR: CANNOT OPEN INPUT FILE"
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

      * VALIDATE CHECKPOINT
           READ INPUT-FILE

           IF INPUT-STATUS = "10"
               DISPLAY "EMPTY DATASET"
               DISPLAY "NO RECORDS TO PROCESS"
               CLOSE INPUT-FILE
               DISPLAY "RETURN CODE: 0"
               MOVE 0 TO RETURN-CODE
               STOP RUN
           END-IF

           PERFORM UNTIL INPUT-STATUS = "10"

               IF INPUT-STATUS NOT = "00"
                   DISPLAY "ERROR: INPUT READ FAILED"
                   CLOSE INPUT-FILE
                   MOVE 8 TO RETURN-CODE
                   STOP RUN
               END-IF

               IF INPUT-RECORD = CHECKPOINT-VALUE
                   MOVE 'Y' TO FOUND-FLAG
               END-IF

               READ INPUT-FILE

           END-PERFORM

           CLOSE INPUT-FILE

           IF FOUND-FLAG = 'N'
               DISPLAY "ERROR: INVALID CHECKPOINT"
               DISPLAY "RETURN CODE: 8"
               MOVE 8 TO RETURN-CODE
               STOP RUN
           END-IF

      * REOPEN INPUT FILE TO PROCESS REMAINING RECORDS
           OPEN INPUT INPUT-FILE

           MOVE 'N' TO EOF-FLAG
           MOVE 'N' TO START-FLAG

           DISPLAY "CHECKPOINT: "
                   FUNCTION TRIM(CHECKPOINT-VALUE)

           DISPLAY "RECORDS TO PROCESS:"

           PERFORM UNTIL EOF-FLAG = 'Y'

               READ INPUT-FILE

               EVALUATE INPUT-STATUS

                   WHEN "10"
                       MOVE 'Y' TO EOF-FLAG

                   WHEN "00"

                       IF START-FLAG = 'Y'
                           DISPLAY FUNCTION TRIM(INPUT-RECORD)
                       END-IF

                       IF INPUT-RECORD = CHECKPOINT-VALUE
                           MOVE 'Y' TO START-FLAG
                       END-IF

                   WHEN OTHER
                       DISPLAY "ERROR: INPUT READ FAILED"
                       CLOSE INPUT-FILE
                       MOVE 8 TO RETURN-CODE
                       STOP RUN

               END-EVALUATE

           END-PERFORM

           CLOSE INPUT-FILE

           DISPLAY "RETURN CODE: 0"

           MOVE 0 TO RETURN-CODE

           STOP RUN.