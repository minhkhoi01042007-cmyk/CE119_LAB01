.data
    so_not: .word 15
    mang_cao_do: .word 64, 64, 65, 67, 67, 65, 64, 62, 60, 60, 62, 64, 64, 62, 62
    mang_do_dai: .word  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  2,  3,  1,  4
    khoang_trang: .asciiz " "
    xuong_dong:   .asciiz "\n"
    msg_du_kien:  .asciiz "Tong du kien (ms): "
    msg_do_duoc:  .asciiz "Thoi gian do duoc (ms): "

.text
main:
    lw $s0, so_not
    la $s1, mang_cao_do
    la $s2, mang_do_dai
    li $s3, 0
    li $s4, 230
    li $s5, 0
    
    li $v0, 30
    syscall
    move $s6, $a0

Phat_Nhac:
    beq $s3, $s0, Ket_Thuc_Phat

    lw $t0, 0($s1)
    addi $t0, $t0, 8

    lw $t1, 0($s2)
    mul $t1, $t1, $s4
    
    add $s5, $s5, $t1         

    li $v0, 1
    move $a0, $t0
    syscall
    
    li $v0, 4
    la $a0, khoang_trang
    syscall
    
    li $v0, 1
    move $a0, $t1
    syscall
    
    li $v0, 4
    la $a0, xuong_dong
    syscall

   # 1. G?i Syscall 31 ?? phát nh?c
    move $a0, $t0
    move $a1, $t1
    li $a2, 0
    li $a3, 100
    li $v0, 31
    syscall
    
    # 2. G?i Syscall 32 ?? Sleep (t?m d?ng CPU)
    li $v0, 32
    move $a0, $t1   # N?p th?i l??ng n?t nh?c (t? $t1) vào $a0 ?? CPU ng?
    syscall

    addi $s1, $s1, 4
    addi $s2, $s2, 4
    addi $s3, $s3, 1
    
    j Phat_Nhac

Ket_Thuc_Phat:
    li $v0, 30
    syscall
    move $s7, $a0
    
    sub $s7, $s7, $s6

    li $v0, 4
    la $a0, msg_du_kien
    syscall
    
    li $v0, 1
    move $a0, $s5
    syscall
    
    li $v0, 4
    la $a0, xuong_dong
    syscall

    li $v0, 4
    la $a0, msg_do_duoc
    syscall
    
    li $v0, 1
    move $a0, $s7
    syscall
    
    li $v0, 4
    la $a0, xuong_dong
    syscall

    li $v0, 10
    syscall
