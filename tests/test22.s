#
# Expected Result: r1 = 0xfb
#
                add     r1  = r0, 0xF0000000;
                addi    r2  = r0, 2;
                lwl     r3  = [r1 + 0];
                andi    r3  = r3, 2;
		cmpneq  p1 = r3, r2;
           (p1) br      -3;
                nop;
                nop;
                lwl     r1  = [r1 + 1];
                halt;
