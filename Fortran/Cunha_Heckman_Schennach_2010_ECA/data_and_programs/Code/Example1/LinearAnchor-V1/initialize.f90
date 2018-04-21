module initialize
use globvar
use probability
implicit none

contains

subroutine init
implicit none

    integer, parameter :: nvar = 18                     !Number of variables in dataset
    character(len=100) :: datafile='data.raw'           !Dataset file
    real(8) :: dataset(nind,ntime,nvar)                 !The dataset
    integer :: i
    integer :: t
    integer :: j
    integer :: s
    integer :: ly(nmea)                                     !location of cogninitive measurements
    integer :: lx(ntime,nmea,nx)
    integer :: ldy(nmea), initial
    integer :: lyanch(nanch)
    integer :: ldanch(nanch)

    !Number of Measurement Equations per Period
    nequation = (/6,6,6,6,6,6,6,6/)
    stage = (/1,1,1,1,1,1,1,1/)

    !Location of Measurement Variables and Missing Indicators
    ly  = (/ 3, 4, 5, 6, 7, 8/)
    ldy = (/10,11,12,13,14,15/)
    
    !Location of Anchoring Equations
    lyanch =  9
    ldanch = 16
    PROBANCH = 0

    !Measurement Equation in each period
    do t = 1, ntime
        eqindex(t,1:nequation(t))=(/1,2,3,4,5,6/)
    end do

    !Any measurement equations nonlinear in the factors?
    nonlinear = 0
    typefunct = 0
    
    !mx(period t, equation k)
    mx = nx

    do t = 1, ntime
        do j = 1, nmea
            lx(t,j,1:nx) = (/17,18/)
        end do
    end do

    OPEN(1,file=datafile)
    DO i = 1, nind
        DO t = 1, ntime
            READ(1,fmt=*) dataset(i,t,:)
        END DO
    END DO
    CLOSE(1)

    do i = 1, nind
        do t = 1, ntime
            Y(i,t,:) = dataset(i,t,ly)
            dY(i,t,:) = int(dataset(i,t,ldy))
        end do
    end do

    do i = 1, nind
        YANCH(i,:)  = dataset(i,ntime,lyanch)
        dYANCH(i,:) = int(dataset(i,ntime,ldanch))
    end do
 
    do i = 1, nind
        do t = 1, ntime
            do j = 1, nmea
                X(i,t,1:mx(t,j)) = dataset(i,t,lx(t,j,:))
            end do
        end do
    end do
  
end subroutine init

end module initialize