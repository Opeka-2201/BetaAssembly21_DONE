|; Bubblesort(array, size):
|;  Sort the given array using the Bubblesort algorithm
|;  @param array Address of array[0] in the DRAM
|;  @param size  Number of elements in the array

.macro SWAP(Ra, Rb, Rtmp1, Rtmp2) LD(Ra,0, Rtmp1) LD(Rb, 0, Rtmp2) ST(Rtmp1, 0, Rb)
.macro ADDR(Ra, Ri, Ro) MULC(Ri,4,Ro) ADD(Ra,Ro,Ro)

bubblesort: 
    PUSH(LP)
    PUSH(BP)
    MOVE(SP,BP)
    PUSH(R1)
    PUSH(R2)
    PUSH(R3) |; holds i_max (size-1)
    PUSH(R4) |; holds i value
    PUSH(R5) |; holds j value
    PUSH(R6) |; holds j_max (i_max - i)
    PUSH(R7) |; holds value of compares to branch
    PUSH(R8) |; holds value of array[i]
    PUSH(R9) |; holds value of array[j]
    PUSH(R10) |; temp register1 to use SWAP
    PUSH(R11) |; temp register2 to use SWAP
    
    LD(BP,-16,R1) |; array
    LD(BP,-12,R2) |; size

    BF(R2,bubblesort_end)

    SUBC(R2,1,R3) |; size-1
    MOVE(R31,R4)
    SUBC(R4,1,R4) |; i = -1
   
bubblesort_loop_1:
    ADDC(R4,1,R4) |; i++
    CMPEQ(R4,R3,R7)
    BT(R7,bubblesort_end)
    MOVE(R31,R5)
    SUBC(R5,1,R5) |; j = -1
    MOVE(R3,R6)
    SUB(R6,R4,R6) |; j_max = size-1-i
    
bubblesort_loop_2:
    ADDC(R5,1,R5)  |; j++
    CMPEQ(R5,R6,R7)
    BT(R7,bubblesort_loop_1)
    ADDR(R1,R4,R8)
    ADDR(R1,R5,R9)
    CMPLT(R9,R8,R7)
    BT(R7,bubblesort_loop_2_swap)
    BR(bubblesort_loop_2)    

bubblesort_loop_2_swap:
    SWAP(R8,R9,R10,R11)
    BR(bubblesort_loop_2)

bubblesort_end:
    POP(R11)
    POP(R10)
    POP(R9)
    POP(R8)
    POP(R7)
    POP(R6)
    POP(R5)
    POP(R4)
    POP(R3)
    POP(R2)
    POP(R1)
    POP(BP)
    POP(LP)