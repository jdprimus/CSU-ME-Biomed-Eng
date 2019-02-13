# Exercise 1
def fasta_to_csv(input_file, output_file):
	"""
	function takes in a fasta file as input_file, reformats to .csv and saves as output_file
	"""
	try:
		fin = open(input_file)
		fout = open(output_file, 'w')
	except:
		return -1
	import re
	line_number = 0
	with fin, fout:
		for line in fin:
			if re.search('>', line):						# if header line
				new_line = line[1::].rstrip()
			elif re.search('A|a|T|t|C|c|G|g|U|u', line):	# if sequence line
				new_line = new_line + ',' + line
				fout.write(new_line)
			else:
				return 'Error: Improperly formatted input file!  Input file must be in fasta format!'
	print(output_file + ' has been saved in your working directory.')

# Exercise 2
def motif_finder(input_file, motif):
	"""
	function searches input_file, assumed to be in fasta format.  
	Returns the number of occurrences of motif. 
	Motif may contain 'N's 
	"""
	try:
		fin = open(input_file)
	except:
		return -1
	import re
	motifs = 0
	index = 0
	with fin:
		sequence = re.sub('\n', '', fin.read())
		motif_nsub = re.sub('N|n', '.', motif)
		while 'TRUE':
			found = re.search(motif_nsub, sequence[index::])	
			if found is None:									# break while if none found
				break
			motifs += 1
			index = index + found.start() + 1					# set start site for next search
	return 'There are ' + str(motifs) + ' occurances of "' + motif + '" in ' + input_file

	
			