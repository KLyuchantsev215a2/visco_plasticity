subroutine Create_Table(x,h,table,N)
    integer :: N,i,j
    real*8 :: x(2,N)
    real*8:: h(N)

    integer :: table(N,120)
    
    real*8::neighbour
    real*8::xi(2)
    real*8::xj(2)
    
    
    do i=1,N
        xi=x(1:2,i)
        cout=0

        
        do j=1,N
        
        xj=x(1:2,j)
        
        neighbour=Compute_W(xi,xj,h(i),h(j)) 
            
            if (neighbour>0) then
                cout=cout+1
                table(i,cout+1)=j
            endif
            
        enddo
        table(i,1)=cout
    enddo

end