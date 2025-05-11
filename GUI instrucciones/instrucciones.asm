ADDI $0 $0 #6
ADDI $1 $1 #2
ADDI $2 $2 #1
ADDI $4 $4 #0
ADDI $5 $5 #0
BEQ $0 $1 #8
ADDI $3 $4 #1
ADDI $5 $2 #0
BEQ $3 $1 #3
ADD $2 $5 $2
ADDI $3 $3 #1
J #8
ADDI $1 $1 #1
J #5
SW $2 $4 #10
