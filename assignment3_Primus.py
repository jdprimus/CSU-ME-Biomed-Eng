# initialization
input_seq = input('Enter a sequence: ')
while input_seq != '':
	output_seq = ''
	noGCs = 0
	rev_comp = ''

	for i in input_seq:
		# RNA to DNA
		if (i == 'U' or i == 'T'):
			output_seq += 'T'
			comp_nt = 'A'
		else:
			output_seq += i
		if i == 'C':
			noGCs += 1
			comp_nt = 'G'
		if i == 'G':
			noGCs += 1
			comp_nt = 'C'
		if i == 'A':
			comp_nt = 'T'	
		rev_comp = comp_nt + rev_comp
			
	# sequence output
	print('Original Sequence:', output_seq)
	
	# reverse complement
	print('Reverse Complement: ', rev_comp)

	# length
	seq_len = len(input_seq)
	print('Length: ', seq_len, ' nt')

	#  % GC
	print('%GC Content: ', round((noGCs/seq_len)*100, 0), '%')

	# Tm
	Tm = 64.9 + 41*((float(noGCs)-16.4)/seq_len) 
	print('Tm: ', round(Tm,1), ' C')
	input_seq = input('Enter a sequence: ')