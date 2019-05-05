        !COMPILER-GENERATED INTERFACE MODULE: Fri May 03 18:55:34 2019
        MODULE CREATE_TABLE__genmod
          INTERFACE 
            SUBROUTINE CREATE_TABLE(X,H,TABLE,N)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: X(2,N)
              REAL(KIND=8) :: H(N)
              INTEGER(KIND=4) :: TABLE(N,120)
            END SUBROUTINE CREATE_TABLE
          END INTERFACE 
        END MODULE CREATE_TABLE__genmod
