        !COMPILER-GENERATED INTERFACE MODULE: Thu Apr 25 11:40:13 2019
        MODULE ONESTEPPLASTICITY__genmod
          INTERFACE 
            SUBROUTINE ONESTEPPLASTICITY(F,MU,K,ETA,DT,CI,N,COUCHY,     &
     &CI_NEW,PK1,YIELDSTRESS)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: F(2,2,N)
              REAL(KIND=8) :: MU
              REAL(KIND=8) :: K
              REAL(KIND=8) :: ETA
              REAL(KIND=8) :: DT
              REAL(KIND=8) :: CI(2,2,N)
              REAL(KIND=8) :: COUCHY(2,2,N)
              REAL(KIND=8) :: CI_NEW(3,3,N)
              REAL(KIND=8) :: PK1(2,2,N)
              REAL(KIND=8) :: YIELDSTRESS
            END SUBROUTINE ONESTEPPLASTICITY
          END INTERFACE 
        END MODULE ONESTEPPLASTICITY__genmod
