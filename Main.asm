; A Conversion of a C program to iterate and operate over elements of an Array
.386  ; Specify instruction set
.model flat, stdcall  ; Flat memory model, std. calling convention
.stack 4096 ; Reserve stack space
ExitProcess PROTO, dwExitCode: DWORD  ; Exit process prototype

.data ; data segment
	; Variables below
	intArray BYTE 3,2,3,1,7,5,7,8,9,2 ; Array we are performing on
	arrayIterator BYTE 0 ; A counter for iterating over the array 

.code ; code segment

main PROC ; main procedure
	; write your assembly code here

	lea ebx, intArray ; loads first element of our array
	mov ah, [ebx + TYPE intArray * 1] ; loads the value of the ith element into ebx

	mov al, 5
	mov [ebx + TYPE intArray * 1], al ; puts the manipulated product back into the relevant space

	INVOKE ExitProcess, 0 ; call exit function
  
main ENDP ; exit main procedure
END main  ; stop assembling