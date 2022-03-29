int main(int argc, char const *argv[]) {
  /* code */
  return 0;
}



/*

(1)

on fait branch de 0

B   =>                        |  10000000
=128 (10)

(2)

addition (3+5) stocke en adresse mem=20
- on met 3 dans r0, on clear r1, on fait r1=r1+r0, on fait r0=5
- on additionne r1=3 + r0=5, et on a le res qu on stocke

LDI => r0 = 3                 |  00100011
CLR => r1 = 0                 |  0111xx01
ACC => r1 = r1 + r0           |  01100100
LDI => r0 = 5                 |  00100101
ACC => r0 = r0 + r1           |  01100001
STR => mem[adresse] = r0      |  01010100

(3)

programme qui fait r1=r2
- on clear r2, et on fait r2=r2+r1

CLR => r2 = 0                 |  0111xx10
ACC => r2 = r2 + r1           |  01101001

(4)

programme qui swap r1 et r2 => r1,r2=r2,r1
- on met r1 dans r3 en vidant r3, et en faisant r3=r3+r1, on vide r1, on fait r1=r1+r2
- on vide r2, on fait r2=r2+r3 (r3 = r1 de base)

CLR => r3 = 0                 |  0111xx11
ACC => r3 = r3 + r1           |  01101101
CLR => r1 = 0                 |  0111xx01
ACC => r1 = r1 + r2           |  01100110
CLR => r2 = 0                 |  0111xx10
ACC => r2 = r2 + r3           |  01101011

(5)




*/
