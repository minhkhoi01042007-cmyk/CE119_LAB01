.data

    msg_nhap:   .asciiz "Nhap so kWh (0..9999): "
    msg_loi:    .asciiz "Gia tri khong hop le, nhap lai.\n"
    msg_kq1:    .asciiz "Tien dien: "
    msg_kq2:    .asciiz " dong\n"
    bieu_gia:   .word 50, 1760      
                .word 50, 1820      
                .word 100, 2110     
                .word 100, 2660     
                .word 100, 3010     
                .word 9999, 3160    
.text
main:
Nhap_Lieu:
    li $v0, 4
    la $a0, msg_nhap
    syscall
    li $v0, 5
    syscall
    sltiu $t0, $v0, 10000       
    beq $t0, $zero, Bao_Loi     
    move $s0, $v0               
    li $s1, 0                   
    la $s2, bieu_gia           
    j Tinh_Tien                 

Bao_Loi:
    li $v0, 4
    la $a0, msg_loi
    syscall
    j Nhap_Lieu
Tinh_Tien:
    beq $s0, $zero, In_Ket_Qua
    lw $t1, 0($s2)              
    lw $t2, 4($s2)              
    bgt $s0, $t1, Vuot_Bac      
    move $t3, $s0               
    li $s0, 0                   
    j Tinh_Tien_Bac
Vuot_Bac:
    move $t3, $t1              
    sub $s0, $s0, $t1           
Tinh_Tien_Bac:
    mul $t4, $t3, $t2           
    add $s1, $s1, $t4           
    addi $s2, $s2, 8           
    j Tinh_Tien
In_Ket_Qua:
    li $v0, 4
    la $a0, msg_kq1
    syscall
    li $v0, 1
    move $a0, $s1
    syscall
    li $v0, 4
    la $a0, msg_kq2
    syscall
    li $v0, 10
    syscall