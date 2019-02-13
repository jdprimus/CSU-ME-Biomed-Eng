"""
DSCI 511 Assignment 5. 

Author:  Jeremy Primus, Oct. 22, 2018

"""
# Exercise 1
def transposer(matrix):
	"""
	function takes a matrix as an input, and returns the transposed version
	"""
	columns = len(matrix[0])
	trans_col = []
	trans_matrix = []
	for i in range(columns):
		trans_col = []
		for row in matrix:
			trans_col.append(row[i])
		trans_matrix.append([trans_col])
		
	return trans_matrix

# Exercise 2
def miRNA_counter(input_fastq_file, input_fasta_file, output_file):
	"""
	function counts the number of small RNA reads in a FASTQ file, compares that to a 
	list of miRNAs in a FASTA file. Output file is then generated containing the number 
	of reads for each miRNA.
	arguments: input_fastq_file - small RNA library - FASTQ
			   input_fasta_file - miRNA sequences - FASTA
			   output_file - miRNA occurrences in small RNA library 
	"""
	try:
		fin_smallRNA = open(input_fastq_file)
		fin_miRNA = open(input_fasta_file)
		fout = open(output_file, 'w')
	except:
		return -1
	line_number = 0
	seq_reads = {}
	with fin_smallRNA, fin_miRNA, fout:
		for line in fin_smallRNA:
			line_number += 1
			if (line_number + 2) % 4 == 0: 						# sequence line
				seq_reads[line] = seq_reads.get(line, 0) + 1	# something to filter non-nucleotides?
		line_number = 0
		miRNA = []
		for line in fin_miRNA:
			line_number += 1
			if (line_number + 1) % 2 == 0: 			# header line
				miRNA.append(line[1::].rstrip())
				fout.write(miRNA[-1])
			elif (line_number) % 2 == 0:
				fout.write('\t' + str(seq_reads.get(line, 0)) + '\n')
	print(output_file + ' has been saved in your working directory.')