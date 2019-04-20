program base
    integer N,i,count_hole,count_section,k1,k2,a!the number of particles that sample the environment
    integer step!counter for time steps
    integer sqn,fr,coutfr,flag
    real*8 :: rho_0, T, l,CFL!density, total calculation time ,the size of the side of the square, Courant number
    real*8 :: S,m,h!body area, mass of a single particle , smoothing radius
    real*8 :: nu,mu,cs_0,E,k,eta,damping,YieldStress !material constants
    real*8 :: dh!indent for calculating the derived kernel through finite differences
    real*8 :: dt,time_calculated!time step, time during calculation
    real*8 :: pi
    real*8, allocatable :: x(:,:)
  
    real*8, allocatable :: xplot(:,:,:)
    real*8, allocatable :: x_init(:,:)
    real*8, allocatable :: table(:,:)
    real*8, allocatable :: v(:,:)
   
    real*8, allocatable :: W(:,:)
    real*8, allocatable :: Wper1(:,:)
    real*8, allocatable :: Wper2(:,:)
    real*8, allocatable :: Wper3(:,:)!tmp
    real*8, allocatable :: Wper4(:,:)!tmp
    real*8, allocatable :: nabla_W(:,:,:)
    real*8, allocatable :: nabla_W_0(:,:,:)
    
    real*8, allocatable :: Couchy(:,:,:)
    real*8, allocatable :: PK1(:,:,:)
    real*8, allocatable :: F(:,:,:)
    real*8, allocatable :: Ci(:,:,:)
    real*8, allocatable :: Ci_new(:,:,:)
    real*8, allocatable :: vol(:)
    
    real*8, allocatable :: acc(:,:)
    real*8, allocatable :: x_0(:,:),x_n_1(:,:),x_n_2(:,:),x_n_1_2(:,:),x_n_3_2(:,:)
    real*8, allocatable :: v_0_0(:,:),v_n_1(:,:),v_n_2(:,:),v_n_1_2(:,:),v_n_3_2(:,:)
    
    integer, allocatable :: index_hole(:)
    integer, allocatable :: index_section(:)
    
     interface
        function Compute_W (xi,xj,h)
            real*8 :: xi(2)
            real*8 :: xj(2)
            real*8 :: h 
            real*8 :: Compute_W
        end function Compute_W
      
        function det (M)
            real*8 :: M(3,3)
            real*8 :: det
        end function det
               
        function trace (M)
            real*8 :: M(3,3)
            real*8 :: trace
        end function trace
        
        function dev (M)
            real*8 :: M(3,3)
            real*8 :: dev(3,3)
        end function dev
      
     end interface
    
    open (unit=1, file="input400.txt")
    open (unit=2, file="output_x.txt", action='write')
    open (unit=3, file="output_C.txt", action='write')
    
       
    
    read (1, 1100) rho_0, T,nu, mu, l, dh,CFL,N 
    write (*, 1113) rho_0, T,nu, mu, l, dh,CFL,N
    flag=0
    sqn=21
    pi=3.14159265359
    
    coutfr=1
    S=1.25*0.6
    m=rho_0*S/N
    
    k=136000.0
    damping=100
    eta=0.1
    YieldStress=335.0
    E=9.0*k*mu/(3.0*k+mu)

    cs_0=sqrt((k+4.0/3.0*mu)/rho_0)
    h=1.4*sqrt(m/rho_0)
    dt=0.00001!CFL*h/(cs_0)
    fr=int(T/dt/50)

    allocate(vol(N))
    allocate(x(2,N))
    allocate(x_init(2,N))
    allocate(xplot(2,N,200))
    allocate(v(2,N))
    allocate(table(N,60))
    
    allocate(acc(2,N))
    allocate(x_0(2,N),x_n_1(2,N),x_n_2(2,N),x_n_1_2(2,N),x_n_3_2(2,N))
    allocate(v_0_0(2,N),v_n_1(2,N),v_n_2(2,N),v_n_1_2(2,N),v_n_3_2(2,N))
    allocate(W(N,N))
    
    allocate(Wper1(N,N))
    allocate(Wper2(N,N))
    allocate(Wper3(N,N))
    allocate(Wper4(N,N))
    allocate(nabla_W_0(2,N,N))
    
    allocate(F(2,2,N))
    allocate(Ci(2,2,N))
    allocate(Ci_new(3,3,N))
    allocate(Couchy(2,2,N))
    allocate(PK1(2,2,N))
   
    vol=m/rho_0
        
    do i=1,N
        read (1, 1110) a,x(1,i),x(2,i)
    enddo
    
   v=0
    !  do i=1,N
   !     read (1, 1110) a,v(1,i),v(2,i)
   !  enddo
    
    call Create_Table(x,h+2*dh,table,N)
    
   count_hole=0
   count_section=0
    
   ! do i=1,N
         

    ! if((x(1,i)<0.1)*(x(2,i)>0.5)) then
     !           count_hole=count_hole+1
     !   end if
        
     !   if ( (x(1,i)>0.7)*(x(2,i)<=0.001))     then
       !         count_section=count_section+1
      !  end if
        
    !enddo
    
    !allocate(index_hole(count_hole))
   ! allocate(index_section(count_section))
     
   ! k1=1
   ! k2=1
   ! do i=1,N
        
    !    if((x(1,i)<0.1)*(x(2,i)>0.5))then     
    !            index_hole(k1)=i
    !            k1=k1+1
    !    end if
        
        
   !     if ( (x(1,i)>0.7)*(x(2,i)<=0.001))     then
   !             index_section(k2)=i                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                                    
  !              k2=k2+1
   !     end if
        
  !  enddo
    x_init=x
    call plot_init(x,N,count_hole,count_section,index_section,index_hole)
   
   
   call Compute_nabla_W(x,h,vol,N,W,Wper1,Wper2,Wper3,Wper4,nabla_W_0,dh,table)!tmp
   call Compute_F(vol,x,x_init,nabla_W_0,N,F,table)
   Ci=F
   call OneStepPlasticity(F,mu,k,eta,dt,Ci,N,Couchy,Ci_new,PK1,YieldStress)
   Ci(1:2,1:2,1:N)=Ci_new(1:2,1:2,1:N)
    
    do step=1,int(T/dt)
        x_0=x
        v_0_0=v
        call Compute_Acceleration(N,h,dh,rho_0,mu,k,eta,damping,vol,F,Couchy,PK1,x_0,x_init,v,nabla_W_0,nabla_W,W,Wper1,Wper2,Wper3,Wper4,acc,count_hole,count_section,index_section,index_hole,Ci,Ci_new,table,YieldStress)
        v=v+dt*acc
        x=x+dt*v
        
       ! do k2=1,count_hole
       !     x(2,index_hole(k2))=x_init(2,index_hole(k2))+0.02*time_calculated*time_calculated
       ! enddo  
        
       ! do k1=1,count_section
       !     x(2,index_section(k1))=x_init(2,index_section(k1))
        !enddo
        
       do k1=1,400,20
          x(1:2,k1)=x_init(1:2,k1);
      enddo
      
      do k1=20,400,20
          x(1:2,k1)=x_init(1:2,k1)+0.02*0.5*(1-cos(pi*time_calculated));
      enddo
        
        time_calculated=(real(step)*dt)
    
       
        call Compute_F(vol,x,x_init,nabla_W_0,N,F,table) 
        call  OneStepPlasticity(F,mu,k,eta,dt,Ci,N,Couchy,Ci_new,PK1,YieldStress)
        Ci(1:2,1:2,1:N)=Ci_new(1:2,1:2,1:N)
        
             
        
        
        if(step-int(step/fr)*fr==0) then
            xplot(1:2,1:N,coutfr)=x
            coutfr=coutfr+1
        end if
        
!        write (2,1111) x(1,index_hole(2))-x_init(1,index_hole(2)),x(2,index_hole(2))-x_init(2,index_hole(2)),time_calculated
        
        !if((time_calculated>=0.66)*(flag==0)) then
       ! flag=1
         !   do k2=1,count_section
                write (3,1112) Couchy(1,1,210),x(1,210)-x_init(1,210)
         !   enddo
       ! end if
    enddo
    
  
    
    pause
    
    call  plot(xplot,N,50)
    
    
    deallocate(vol)
    deallocate(x)
    deallocate(x_init)
    deallocate(xplot)
    deallocate(v)
    deallocate(table)
    
    deallocate(acc)
    deallocate(x_0,x_n_1,x_n_2,x_n_1_2,x_n_3_2)
    deallocate(v_0_0,v_n_1,v_n_2,v_n_1_2,v_n_3_2)
    deallocate(W)
    
    deallocate(Wper1)
    deallocate(Wper2)
    deallocate(Wper3)
    deallocate(Wper4)
    deallocate(nabla_W_0)
    
    deallocate(F)
    deallocate(Ci)
    deallocate(Ci_new)
    deallocate(Couchy)
    deallocate(PK1)
    
     1100 format (7f10.6,1i4)
    1113 format ("Density "1f12.6,/,"Time "1f10.6,/,"Poisson's ratio " 1f10.6,/,"Shear modulus " 1f15.6,/,"Side of a square " 1f10.6,/,"For finite difference " 1f10.6,/,"CFL " 1f10.6,/,"Particle count " 1i4)
    1110 format (1i12,1f25.0,1f20.0)
    1111 format (3f10.6)
1112     format (3f13.6)
    
    end program base
    
    
    function Compute_W(xi,xj,h)
        real*8::xi(2)
        real*8::xj(2)
        real*8::h
        
        real*8::r(2)
        real*8::q
        real*8::C
        real*8::KER
        KER=0
        r=xi-xj
        q=sqrt(r(1)*r(1)+r(2)*r(2))/h
        C=1.0/(3.14159265358979323846*h*h)

        if((q>=0)*(q<=1)) then
               KER=C*(10.0 / 7.0)*(1.0-3.0/2.0*q*q*(1.0-q/2.0))
        end if
    
        if ((q > 1) * (q <=2)) then
            KER = C*(10.0 / 7.0)*(1.0/4.0)*(2.0 - q)*(2.0 - q)*(2.0 - q)
        end if
        
    
    Compute_W=KER
    end function Compute_W
    
    function det (M)
         real*8 :: M(3,3)
         real*8 ::det
         det=(M(1,1)*M(2,2)-M(1,2)*M(2,1))*M(3,3)
         
    end function det
        
    function trace (M)
            real*8 :: M(3,3)
            real*8 :: trace
            trace=M(1,1)+M(2,2)+M(3,3)
    end function trace
    
  
    
    
    
