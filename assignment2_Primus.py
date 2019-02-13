## Exercise 1
def nt_id(seq):
	"""
	function takes in a nucleotide sequence as an argument, identifies 
	whether the sequence is DNA (contains T's') or RNA (contains A's) or 
	indeterminate (contains neither)    
	"""	
	if 'T' in seq:
		id = 'DNA'
	elif 'U' in seq:
		id = 'RNA'
	else:
		print('Could be either')
		id = 'indeterminate'
	return(id) 

if __name__ == '__main__':
    seq = input('Enter a sequence: ')
    print(nt_id(seq))

## Exercise 2
def stop_codon(seq):
	"""
	function takes in a nucleotide sequence as an argument, identifies
	whether a stop codon is present.  
	"""	
	if ('UAG' in seq) or ('UAA' in seq) or ('UGA' in seq):
		tf = True
	else:
		tf = False
	return(tf) 
	
if __name__ == '__main__': 
	seq = input('Enter a sequence: ')
	print(stop_codon(seq))
	
## Exercise 3
def peptide_length(seq):
	"""
	function takes in a nucleotide sequence as an argument, identifies 
	the maximum peptide length
	"""	
	# in an effort to only use functionality discussed in class
	# also assuming that we don't need to consider only nucleotides 
	# after a start codon, as that would require indexing the location--
	# functionality that has not been introduced yet in class
	rem = len(seq)%3
	maxlen = int((len(seq)-rem)/3)
	print('Maximum length peptide chain from this sequence')
	return(maxlen)
	
if __name__ == '__main__': 
	seq = input('Enter a sequence: ')
	print(peptide_length(seq))
	
## Exercise 4
def cube_root(n):
	"""
	function takes in a number as an argument, returns the cubic root
	of the value
	"""	
	try:
		n = float(n)
		cuberoot = n**(1/3)
		return(cuberoot)
	except:
		print('Error: Non-numerical value given as input!')
		
if __name__ == '__main__': 
	number = input('Enter a numeric value to recieve its cubic root: ')
	print(cube_root(number))
	
## Exercise 5
def sum_num(n1,n2=0,n3=0,n4=0):
	'''
	computes the sum of up to four arguments
	'''
	return(sum([n1,n2,n3,n4]))
	
## Exercise 6
'''
simple script which takes an RNA sequence as input, calls stop_codon function to detect
start codon and outputs informative message
'''
seq1 = input('Enter a sequence: ')
import stop_codon
tf = stop_codon.stop_codon(seq1)
if tf == True:
	print('RNA sequence contains a stop codon.')
else:
	print('RNA sequence does not contain a stop codon')

