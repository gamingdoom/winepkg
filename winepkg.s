	.text
	.section	.rodata
	.align 8
.LC0:
	.string	"Too Many Arguments, Try\nwinepkg --help"
	.align 8
.LC1:
	.string	"Not Enough Arguments, Try\nwinepkg --help"
.LC2:
	.string	"--help"
	.align 8
.LC3:
	.string	"Usage:\nwinepkg -Si <packagename>\nwinepkg -l\n-S    Sync (refresh package lists)\n-i    Install Package\n-l    List Packages\n-Sl   Sync and List Packages"
.LC4:
	.string	"-Sl"
.LC5:
	.string	"Syncing Package Lists ...."
	.align 8
.LC6:
	.string	"Here are the packages! Run winepkg -l | grep <packagename> to sort them"
.LC7:
	.string	"-Sli"
.LC8:
	.string	"-Si"
.LC9:
	.string	"-S"
.LC10:
	.string	"-i"
.LC11:
	.string	"-l"
.LC12:
	.string	"-"
	.align 8
.LC13:
	.string	"Argument not found. Run winepkg --help for the list of valid commands"
	.align 8
.LC14:
	.string	"At least 1 argument is required"
	.text
	.globl	main
	.type	main, @function
main:
.LFB6:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	subq	$16, %rsp
	movl	%edi, -4(%rbp)
	movq	%rsi, -16(%rbp)
	cmpl	$3, -4(%rbp)
	jle	.L2
	leaq	.LC0(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L3
.L2:
	cmpl	$1, -4(%rbp)
	jg	.L4
	leaq	.LC1(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
.L4:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC2(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L5
	leaq	.LC3(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L6
.L5:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC4(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L7
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	call	sync
	testl	%eax, %eax
	jne	.L6
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	call	list
	movl	$10, %edi
	call	putchar@PLT
	jmp	.L6
.L7:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC7(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L8
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	call	sync
	testl	%eax, %eax
	jne	.L9
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	call	list
	movl	$10, %edi
	call	putchar@PLT
.L9:
	movq	-16(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	install
	jmp	.L6
.L8:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC8(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L10
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	call	sync
	movq	-16(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	install
	jmp	.L6
.L10:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC9(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L11
	leaq	.LC5(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	call	sync
	jmp	.L6
.L11:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC10(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L12
	movq	-16(%rbp), %rax
	addq	$16, %rax
	movq	(%rax), %rax
	movq	%rax, %rdi
	call	install
	jmp	.L6
.L12:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	leaq	.LC11(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	jne	.L13
	leaq	.LC6(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$0, %eax
	call	list
	movl	$10, %edi
	call	putchar@PLT
	jmp	.L6
.L13:
	movq	-16(%rbp), %rax
	addq	$8, %rax
	movq	(%rax), %rax
	movzbl	(%rax), %eax
	movzbl	.LC12(%rip), %edx
	movzbl	%al, %eax
	movzbl	%dl, %edx
	subl	%edx, %eax
	testl	%eax, %eax
	jne	.L14
	leaq	.LC13(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	jmp	.L6
.L14:
	leaq	.LC14(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
.L6:
	movl	$0, %eax
.L3:
	leave
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE6:
	.size	main, .-main
	.section	.rodata
.LC15:
	.string	"mkdir -p ~/.winepkg/"
	.align 8
.LC16:
	.string	"curl -L http://gamingdoom.github.io/winepkg/pkglist > ~/.winepkg/pkglist"
.LC17:
	.string	"SERVER NOT FOUND"
	.text
	.globl	sync
	.type	sync, @function
sync:
.LFB7:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC15(%rip), %rax
	movq	%rax, %rdi
	call	system@PLT
	leaq	.LC16(%rip), %rax
	movq	%rax, %rdi
	call	system@PLT
	testl	%eax, %eax
	je	.L16
	leaq	.LC17(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L17
.L16:
	movl	$0, %eax
.L17:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE7:
	.size	sync, .-sync
	.section	.rodata
	.align 8
.LC18:
	.string	"cat ~/.winepkg/pkglist | awk '{ print $1 }'"
	.align 8
.LC19:
	.string	"File not found. Please run winepkg -S first."
	.text
	.globl	list
	.type	list, @function
list:
.LFB8:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	leaq	.LC18(%rip), %rax
	movq	%rax, %rdi
	call	system@PLT
	testl	%eax, %eax
	je	.L19
	leaq	.LC19(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$1, %eax
	jmp	.L18
.L19:
.L18:
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE8:
	.size	list, .-list
	.section	.rodata
.LC20:
	.string	"HOME"
.LC21:
	.string	"r"
.LC22:
	.string	" "
	.align 8
.LC23:
	.string	"ERROR couldn't find any matching packages"
	.align 8
.LC24:
	.string	"Would you like to install this program as a command (/usr/bin) [Y/n]"
	.align 8
.LC25:
	.string	"Installing to /usr/bin Please enter your password"
	.align 8
.LC26:
	.string	"Not Installing To /usr/bin. If you would like this, please re-run this command and type y"
	.text
	.globl	install
	.type	install, @function
install:
.LFB9:
	.cfi_startproc
	pushq	%rbp
	.cfi_def_cfa_offset 16
	.cfi_offset 6, -16
	movq	%rsp, %rbp
	.cfi_def_cfa_register 6
	pushq	%r15
	pushq	%r14
	pushq	%r12
	pushq	%rbx
	subq	$267328, %rsp
	.cfi_offset 15, -24
	.cfi_offset 14, -32
	.cfi_offset 12, -40
	.cfi_offset 3, -48
	movq	%rdi, -267352(%rbp)
	movq	%fs:40, %rax
	movq	%rax, -40(%rbp)
	xorl	%eax, %eax
	leaq	.LC20(%rip), %rax
	movq	%rax, %rdi
	call	getenv@PLT
	movq	%rax, -267328(%rbp)
	movq	-267328(%rbp), %rdx
	leaq	-5168(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-5168(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-5168(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$7741799284340108847, %rsi
	movabsq	$8316297378356277095, %rdi
	movq	%rsi, (%rax)
	movq	%rdi, 8(%rax)
	movw	$116, 16(%rax)
	leaq	-5168(%rbp), %rax
	leaq	.LC21(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	fopen@PLT
	movq	%rax, -267320(%rbp)
	jmp	.L22
.L24:
	movq	-267352(%rbp), %rdx
	leaq	-4912(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strstr@PLT
	testq	%rax, %rax
	jne	.L38
.L22:
	movq	-267320(%rbp), %rdx
	leaq	-4912(%rbp), %rax
	movl	$256, %esi
	movq	%rax, %rdi
	call	fgets@PLT
	testq	%rax, %rax
	jne	.L24
	jmp	.L23
.L38:
	nop
.L23:
	movq	-267320(%rbp), %rax
	movq	%rax, %rdi
	call	fclose@PLT
	leaq	-4912(%rbp), %rax
	leaq	.LC22(%rip), %rdx
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strtok@PLT
	movq	%rax, -267336(%rbp)
	movl	$0, -267340(%rbp)
	jmp	.L25
.L26:
	leaq	-267312(%rbp), %rdx
	movl	-267340(%rbp), %eax
	cltq
	salq	$9, %rax
	addq	%rax, %rdx
	movq	-267336(%rbp), %rax
	movq	%rax, %rsi
	movq	%rdx, %rdi
	call	strcpy@PLT
	addl	$1, -267340(%rbp)
	leaq	.LC22(%rip), %rax
	movq	%rax, %rsi
	movl	$0, %edi
	call	strtok@PLT
	movq	%rax, -267336(%rbp)
.L25:
	cmpq	$0, -267336(%rbp)
	jne	.L26
	movq	-267352(%rbp), %rdx
	leaq	-267312(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcmp@PLT
	testl	%eax, %eax
	je	.L27
	leaq	.LC23(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$2, %eax
	jmp	.L21
.L27:
	movq	-267328(%rbp), %rdx
	leaq	-4656(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-4656(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-4656(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$7741799284340108847, %rcx
	movq	%rcx, (%rax)
	movw	$12135, 8(%rax)
	movb	$0, 10(%rax)
	leaq	-267312(%rbp), %rdx
	leaq	-4656(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-4656(%rbp), %rax
	movl	$448, %esi
	movq	%rax, %rdi
	call	mkdir@PLT
	leaq	-4656(%rbp), %rdx
	leaq	-4144(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-4144(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-4144(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$7812726606361684271, %rcx
	movq	%rcx, (%rax)
	movl	$3109477, 8(%rax)
	leaq	-4144(%rbp), %rax
	movl	$448, %esi
	movq	%rax, %rdi
	call	mkdir@PLT
	movb	$0, -3632(%rbp)
	leaq	-3632(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-3632(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$2337699298997004151, %r14
	movabsq	$8083248226577362221, %r15
	movq	%r14, (%rax)
	movq	%r15, 8(%rax)
	movabsq	$2338339511083691890, %rbx
	movq	%rbx, 16(%rax)
	movl	$757091885, 24(%rax)
	movw	$8272, 28(%rax)
	movb	$0, 30(%rax)
	leaq	-4144(%rbp), %rdx
	leaq	-3632(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-3632(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-3632(%rbp), %rax
	addq	%rdx, %rax
	movw	$32, (%rax)
	leaq	-267312(%rbp), %rax
	leaq	512(%rax), %rdx
	leaq	-3632(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-3632(%rbp), %rax
	movq	%rax, %rdi
	call	system@PLT
	leaq	-4656(%rbp), %rdx
	leaq	-3120(%rbp), %rax	.ident	"GCC: (GNU) 11.1.0"
	.section	.note.GNU-stack,"",@progbits
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcpy@PLT
	leaq	-3120(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-3120(%rbp), %rax
	addq	%rdx, %rax
	movl	$1702389039, (%rax)
	movw	$47, 4(%rax)
	leaq	-3120(%rbp), %rax
	movl	$448, %esi
	movq	%rax, %rdi
	call	mkdir@PLT
	movb	$0, -2608(%rbp)
	leaq	-2608(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-2608(%rbp), %rax
	addq	%rdx, %rax
	movq	%r14, (%rax)
	movq	%r15, 8(%rax)
	movq	%rbx, 16(%rax)
	movl	$757091885, 24(%rax)
	movw	$8272, 28(%rax)
	movb	$0, 30(%rax)
	leaq	-3120(%rbp), %rdx
	leaq	-2608(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-2608(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-2608(%rbp), %rax
	addq	%rdx, %rax
	movw	$32, (%rax)
	leaq	-267312(%rbp), %rax
	leaq	1024(%rax), %rdx
	leaq	-2608(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-2608(%rbp), %rax
	movq	%rax, %rdi
	call	system@PLT
	movb	$0, -2096(%rbp)
	leaq	-2096(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-2096(%rbp), %rax
	addq	%rdx, %rax
	movl	$2122851, (%rax)
	leaq	-4144(%rbp), %rdx
	leaq	-2096(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-2096(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-2096(%rbp), %rax
	addq	%rdx, %rax
	movl	$539371040, (%rax)
	movb	$0, 4(%rax)
	leaq	-2096(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-2096(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$3978684411543382115, %r12
	movq	%r12, (%rax)
	movw	$8245, 8(%rax)
	movb	$0, 10(%rax)
	leaq	-4144(%rbp), %rdx
	leaq	-2096(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-2096(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-2096(%rbp), %rax
	addq	%rdx, %rax
	movl	$640032810, (%rax)
	movw	$32, 4(%rax)
	leaq	-2096(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-2096(%rbp), %rax
	addq	%rdx, %rax
	movl	$1667594341, (%rax)
	movw	$32, 4(%rax)
	leaq	-4144(%rbp), %rdx
	leaq	-2096(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-267312(%rbp), %rdx
	leaq	-2096(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-2096(%rbp), %rax
	movq	%rax, %rdi
	call	system@PLT
	movb	$0, -1584(%rbp)
	leaq	-1584(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-1584(%rbp), %rax
	addq	%rdx, %rax
	movq	%r14, (%rax)
	movq	%r15, 8(%rax)
	movq	%rbx, 16(%rax)
	movl	$757091885, 24(%rax)
	movw	$8272, 28(%rax)
	movb	$0, 30(%rax)
	leaq	-4656(%rbp), %rdx
	leaq	-1584(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-1584(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-1584(%rbp), %rax
	addq	%rdx, %rax
	movw	$32, (%rax)
	leaq	-267312(%rbp), %rax
	leaq	1536(%rax), %rdx
	leaq	-1584(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-1584(%rbp), %rax
	movq	%rax, %rdi
	call	system@PLT
	movb	$0, -1072(%rbp)
	leaq	-1072(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-1072(%rbp), %rax
	addq	%rdx, %rax
	movq	%r12, (%rax)
	movw	$8245, 8(%rax)
	movb	$0, 10(%rax)
	leaq	-4656(%rbp), %rdx
	leaq	-1072(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-1072(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-1072(%rbp), %rax
	addq	%rdx, %rax
	movw	$47, (%rax)
	leaq	-267312(%rbp), %rdx
	leaq	-1072(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-1072(%rbp), %rax
	movq	%rax, %rdi
	call	system@PLT
	movb	$0, -267341(%rbp)
	leaq	.LC24(%rip), %rax
	movq	%rax, %rdi
	movl	$0, %eax
	call	printf@PLT
	jmp	.L29
.L31:
	call	getchar@PLT
	movb	%al, -267341(%rbp)
.L29:
	cmpb	$121, -267341(%rbp)
	je	.L30
	cmpb	$110, -267341(%rbp)
	je	.L30
	cmpb	$10, -267341(%rbp)
	jne	.L31
.L30:
	cmpb	$110, -267341(%rbp)
	jne	.L32
	movl	$0, %eax
	jmp	.L21
.L32:
	cmpb	$10, -267341(%rbp)
	je	.L33
	cmpb	$121, -267341(%rbp)
	jne	.L34
.L33:
	leaq	.LC25(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movb	$0, -560(%rbp)
	leaq	-560(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-560(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$2336924143215474035, %rcx
	movq	%rcx, (%rax)
	movl	$543585069, 8(%rax)
	movb	$0, 12(%rax)
	leaq	-4656(%rbp), %rdx
	leaq	-560(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-560(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-560(%rbp), %rax
	addq	%rdx, %rax
	movw	$47, (%rax)
	leaq	-267312(%rbp), %rdx
	leaq	-560(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-560(%rbp), %rax
	movq	%rax, %rdi
	call	strlen@PLT
	movq	%rax, %rdx
	leaq	-560(%rbp), %rax
	addq	%rdx, %rax
	movabsq	$7593684090309914400, %rcx
	movq	%rcx, (%rax)
	movw	$12142, 8(%rax)
	movb	$0, 10(%rax)
	leaq	-267312(%rbp), %rdx
	leaq	-560(%rbp), %rax
	movq	%rdx, %rsi
	movq	%rax, %rdi
	call	strcat@PLT
	leaq	-560(%rbp), %rax
	movq	%rax, %rdi
	call	puts@PLT
	leaq	-560(%rbp), %rax
	movq	%rax, %rdi
	call	system@PLT
	nop
	jmp	.L21
.L34:
	leaq	.LC26(%rip), %rax
	movq	%rax, %rdi
	call	puts@PLT
	movl	$2, %eax
.L21:
	movq	-40(%rbp), %rdx
	subq	%fs:40, %rdx
	je	.L37
	call	__stack_chk_fail@PLT
.L37:
	addq	$267328, %rsp
	popq	%rbx
	popq	%r12
	popq	%r14
	popq	%r15
	popq	%rbp
	.cfi_def_cfa 7, 8
	ret
	.cfi_endproc
.LFE9:
	.size	install, .-install
