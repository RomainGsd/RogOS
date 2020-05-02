	.data
	delay: .quad 5

	.text
	.global sleep

sleep:
	push %ebp # save ebp
	movl %esp, %ebp

	movl -4(%ebp), %edi # ebp contains first argument
	movl $35, %eax	# 35 ("nanosleep")
	movl $0, %esi
	int  $0x80

	pop %ebp
	movl $60, %eax   # 1 ("exit")
	movl $0, %edi
	int  $0x80
