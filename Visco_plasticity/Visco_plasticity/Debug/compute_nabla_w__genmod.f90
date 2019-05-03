        !COMPILER-GENERATED INTERFACE MODULE: Fri May 03 15:24:01 2019
        MODULE COMPUTE_NABLA_W__genmod
          INTERFACE 
            SUBROUTINE COMPUTE_NABLA_W(X,H,VOL,N,W,WPER1,WPER2,WPER3,   &
     &WPER4,NABLA_W,DH,TABLE)
              INTEGER(KIND=4) :: N
              REAL(KIND=8) :: X(2,N)
              REAL(KIND=8) :: H(N)
              REAL(KIND=8) :: VOL(N)
              REAL(KIND=8) :: W(N,N)
              REAL(KIND=8) :: WPER1(N,N)
              REAL(KIND=8) :: WPER2(N,N)
              REAL(KIND=8) :: WPER3(N,N)
              REAL(KIND=8) :: WPER4(N,N)
              REAL(KIND=8) :: NABLA_W(2,N,N)
              REAL(KIND=8) :: DH
              INTEGER(KIND=4) :: TABLE(N,60)
            END SUBROUTINE COMPUTE_NABLA_W
          END INTERFACE 
        END MODULE COMPUTE_NABLA_W__genmod
