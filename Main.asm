; A Conversion of a C program to iterate and operate over elements of an Array
.386  ; Specify instruction set
.model flat, stdcall  ; Flat memory model, std. calling convention
.stack 4096 ; Reserve stack space
ExitProcess PROTO, dwExitCode: DWORD  ; Exit process prototype

.data ; data segment
	; Variables below
	intArray DWORD 3,2,3,1,7,5,7,8,9,2 ; Array we are performing on
	arrayIterator DWORD 0 ; A counter for iterating over the array  
	Scalar DWORD 3 ; Stores 3, for use in both multiplication and division in NewItem

.code ; code segment

main PROC ; main procedure
	; write your assembly code here
	; if i is array iterator then we are performing 2 * i + 1 / 3 + i * 3 (from left to right) then adding it to the i'th element in array intArray
	NewItem: ; This loop iterates our calculaton, defined above, on every element of our array
		mov eax, arrayIterator ; moves our arrayiterator into eax for manipulation
		add eax, eax ; instead of multiplying by 2, we can just add eax to itself
		inc eax ; adds one to eax 
		mov ebx, 3 ; moves our divisor, 3, into ebx 
		mov edx, 0 ; clears the dividend as we are working in 32 bit ints, this could hold garbage data we should clear
		div ebx ; puts our quotient, as all we are interested in, into eax
		add eax, arrayIterator ; adds our stage in the loop onto eax
		mul Scalar ; should push eax * 3 into EDX:EAX, although as no digit will reach over a 32 bit value, we can ignore the edx result
		mov ebx, arrayIterator ; loads our array iterator into ebx to find which element to add eax to
		mov ecx, OFFSET intArray ; puts the start of array intArray into ecx
		mov edx, [ecx + TYPE intArray * ebx] ; moves the value to add into edx
		add eax, edx ; adds our relevant array value from edx, to eax
		mov [ecx + TYPE intArray * ebx], eax ; writes our now fully completed value back to the array intArray
		inc arrayIterator; increments our counter
		cmp arrayIterator, 10; if counter is still less than 10, we jump back to do the next element, as array is not finished
		jne NewItem ; jumps back to line 18 to execute code on new item
	INVOKE ExitProcess, 0 ; call exit function
main ENDP ; exit main procedure
END main  ; stop assembling