"""
DSCI 511 Assignment 4.
 
Author:  Jeremy Primus, Oct. 15, 2018
 
"""
# Exercise 1
def fastq_fasta(input_file, output_file):
	""""
	function takes an input file in FASTQ format, reformats to FASTA, and saves as output_file
	"""
	try:
		fin = open(input_file)
		fout = open(output_file, 'w')
	except:
		return -1
	line_number = 0
	seq = ''
	for line in fin:
		line_number += 1
		if (line_number + 3) % 4 == 0:					# header line
			header = '>' + line
			fout.write(header)
		elif (line_number + 2) % 4 == 0: 					# sequence line
			fout.write(line)
	fin.close()
	fout.close()
	print(output_file + ' has been saved in your working directory.')
	print('No. of reads in file: ')
	return(line_number/4)


# Exercise 2
def fastq_trimmer(input_file, output_file, trim_5p, trim_3p):
	"""
	function accepts fastq formatted files as input, trims the reads by at the 5' and 3' end
	by the number of nucleotides given in arguments trim_5p and trim_3p.  The resulting output
	is saved as output_file argument
	"""
	if trim_5p + trim_3p > 50:
		return 'Error: You have trimmed the entire read.'
	try:
		fin = open(input_file)
		fout = open(output_file, 'w')
	except:
		return -1
	line_number = 0
	seq = ''
	with fin, fout:
		for line in fin:
			line_number += 1
			if (line_number + 3) % 4 == 0: 			# header line
				fout.write(line)
			elif (line_number + 1) % 4 == 0: 			# header line
				fout.write(line)
			else:
				trimmed_line = line[trim_5p:(len(line)-trim_3p-1)] + '\n'
				fout.write(trimmed_line)
	print(output_file + ' has been saved in your working directory.')
	print('No. of reads in file: ')
	return(line_number/4)

if __name__ == '__main__':
    """
    This segment of the program is used for testing the code.
    It is automatically executed when you run the file as a script
    but not when it is imported as a module.
 
    For details, see:
    https://docs.python.org/3/library/__main__.html
 
    For a more in-depth explanation with examples, see:
    http://www.bogotobogo.com/python/python_if__name__equals__main__.php
    """
    infile = input('Enter the name of a FASTQ file in your working directory which you would like to convert to FASTA: ')
    outfile = input('Enter a name for the FASTA output:')
    print(fastq_fasta(infile, outfile))
    infile = input('Enter the name of a FASTAQ file to trim: ')
    outfile = input('Enter a filename for output FASTQ file: ')
    trim_start = int(input('How many nucleotides to trim off start? '))
    trim_end = int(input('How many nucleotides to trim off end? '))
    print(fastq_trimmer(infile, outfile, trim_start, trim_end))