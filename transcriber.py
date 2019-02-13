def transcriber(input_file_name):
	fin = open(input_file_name)
	seq = ''
	for line in fin:
		if line[0] != '>':
			seq += line
		else:
			header = line
		
	RNA = seq.replace('T', 'U')
	RNA = header + RNA
	print(RNA)