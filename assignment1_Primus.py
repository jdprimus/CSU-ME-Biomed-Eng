# Exercise 1
seq1 = input('Enter the first DNA sequence:')
seq2 = input('Enter the second DNA sequence:')
fullseq = seq1+seq2
print('Concatenated sequence:', fullseq) 

# Exercise 2
h = input('Enter the height of the beaker: ')
r = input('Enter the radius of the beaker: ')
h = float(h)
r = float(r)
v = 3.14*h*r**2
print('The volume of the beaker is:', v)

# Exercise 3
seq = input('Enter a codon sequence: ')
if seq == 'ATG':
	print('Sequence is a start codon!')
else:
	print('Sequence is not a start codon!')
	
# Exercise 4
seq = input('Enter the DNA sequence:')
compseq = input('Enter the complementary DNA sequence:')
n = len(seq)
print(seq)
print(n*'|')
print(compseq)

# Exercise 5
print('type(True) = ')
print(type(True))
print('type(False) = ')
print(type(False))
print('type(5) = ')
print(type(5))
print('type(5.0) = ')
print(type(5.0))
print("type('5') = ")
print(type('5'))
print("type('ACG') = ")
print(type('ACG'))