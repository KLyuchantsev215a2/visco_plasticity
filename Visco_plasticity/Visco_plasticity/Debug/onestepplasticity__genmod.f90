        !COMPILER-GENERATED INTERFACE MODULE: Sun Apr 07 16:12:15 2019
        MODULE ONESTEPPLASTICITY__genmod
          INTERFACE 
            SUBROUTINE ONESTEPPLASTICITY(F,MU,K,ETA,DT,CI,N,COUCHY,     &
     &CI_NEW,PK1,FRICTION)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: F(2,2,N)
              REAL(KIND=8) :: MU
              REAL(KIND=8) :: K
              REAL(KIND=8) :: ETA
              REAL(KIND=8) :: DT
              REAL(KIND=8) :: CI(2,2,N)
              REAL(KIND=8) :: COUCHY(2,2,N)
              REAL(KIND=8) :: CI_NEW(3,3,N)
              REAL(KIND=8) :: PK1(3,3,N)
              REAL(KIND=8) :: FRICTION
            END SUBROUTINE ONESTEPPLASTICITY
          END INTERFACE 
        END MODULE ONESTEPPLASTICITY__genmod
