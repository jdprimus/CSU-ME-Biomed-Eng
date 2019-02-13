"""
DSCI 511 Final Exam
 
Author:  Jeremy Primus, Nov. 1, 2018
 
"""
# Problem 1
def gc_content(sequence):
	"""
	function takes in a DNA/RNA sequence and returns the fractional GC content of that 
	sequence
	"""
	noGCs = 0
	for i in sequence:
		if i == 'C':
			noGCs += 1
			print(noGCs)
		if i == 'G':
			noGCs += 1	
			print(noGCs)		
	# length
	seq_len = len(sequence)
	print(seq_len)
	#  fractional GC
	print('Fractional GC Content: ', round((noGCs/seq_len), 2))
	
# Problem 2
def word_count(input_file):
	"""
	function counts the number of characters (excluding new line characters) and 
	lines in input file.
	returns line_count and char_count as a tuple
	"""
	try:
		fin = open(input_file)
	except:
		return -1
	line_count = 0 
	char_count = 0 
	with fin:
		for line in fin:
			char_count += len(line.rstrip('\n'))
			line_count += 1
	print('Lines: ', line_count)
	print('Characters: ', char_count)
	return((line_count, char_count))
	
# Problem 3
def matrix_mean(matrix):
	"""
	function returns the mean of each matrix row
	"""
	rows = len(matrix)
	row_avgs = []
	for row in range(rows):
		row_avg = sum(matrix[row])/len(matrix[row])
		row_avgs.append(row_avg)
	return row_avgs
	
# Problem 4
def element_counter(some_list):
	"""
	function takes in some_list, and returns a dictionary of unique elements and 
	number of occurrences in the list
	"""
	unique_elements = {}
	for element in some_list:
		unique_elements[element] = unique_elements.get(element, 0) + 1
	return unique_elements

# Problem 5
def motif_coordinates(sequence, motif):
	"""
	function reads in a dna sequence.  scans for motif, and returns the coordinates in 
	non-pythonic, traditional indexing
	"""
	if motif in sequence:
		length = len(motif)
		for i in range(len(sequence)):
			if sequence[i:i+length] == motif:
				return (i+1, i+length)
	else:
		return 'Motif not found in sequence.'
	
	