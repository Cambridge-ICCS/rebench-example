program example
  implicit none

  real              :: startTime, finishTime
  character(len=32) :: argument1
  character(len=32) :: argument2
  integer           :: multiplier  = 1
  logical           :: colMajorFlag = .true.


  ! configuration of this benchmark from command line args
  
  if (command_argument_count() > 1) then

    ! size parameter
    if (command_argument_count() > 2) then
      call get_command_argument(3, argument2)
      read (argument2,'(I10)') multiplier
      print '("Size = ",i10)', multiplier
    end if

    call get_command_argument(2, argument1)

    ! process arguments
    select case (argument1)
      case ('-c', '--column')
        colMajorFlag = .true.
        print '("Column-major mode.")'
        call benchmark()
        stop

      case ('-r', '--row')
        colMajorFlag = .false.
        print '("Row-major mode.")'
        call benchmark()
        stop

      case default
        call print_help()
        stop
      end select

  else
    call print_help()
  end if

contains

    subroutine benchmark()
      call cpu_time(startTime)
      ! code to test
      call traverse(colMajorFlag, multiplier)
      call cpu_time(finishTime)
      ! report results for PlainSecondsLog
      print '(f6.3)', (finishTime - startTime)
    end subroutine benchmark

    ! Create a square array, fill it with data
    ! then compute an averaging stencil over it
    ! in either row-major or column-major order
    subroutine traverse(colMajorFlag, multiplier)
      logical                :: colMajorFlag
      integer                :: multiplier
      integer                :: n
      real, dimension (:, :), allocatable :: x
      integer                :: i, j

      n = 10000 * multiplier
      allocate (x(n, n))

      ! Fill up array with some data
      do i = 1, n
         do j = 1, n
            x(i,j) = i*n+j
         end do
      end do

      ! Do convolution (with flag to flip which dimension
      ! gets 'visited' first).
      do i = 2, n-1
         do j = 2, n-1
            if (colMajorFlag) then
               x(j,i) = (x(j,i)+x(j-1,i)+x(j+1,i)+x(j,i-1)+x(j,i+1))/5.0
            else
               x(i,j) = (x(i,j)+x(i-1,j)+x(i+1,j)+x(i,j-1)+x(i,j+1))/5.0
            end if
         end do
      end do

      deallocate (x)

    end subroutine traverse

    ! Help routine
    subroutine print_help()
        print '(a, /)', 'example benchmark <option> [multiplier]'
        print '(a, /)', 'command-line options:'
        print '(a)',    '  -c, --column      run benchmark in column-major mode'
        print '(a)',    '  -r, --row         run benchmark in row-major mode'
        print '(a, /)', '  -h, --help        print usage information and exit'
        print '(a, /)', 'e.g., example benchmark -r 10'
    end subroutine print_help

end program example
