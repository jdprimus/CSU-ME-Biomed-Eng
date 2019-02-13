def arg_parse():
    """
    Parse command line arguments
    """
    import argparse
    # First we need to create an instance of ArgumentParser which we will call parser:
    parser = argparse.ArgumentParser()
    # The add_argument() method is called for each argument:
    # We provide two version of each argument: 
    # -a is the shortand, --sequence1 is the longhand
    # We can specify a help message describing the argument with help="message"
    # To require an argument, we use required=True
    parser.add_argument('-a', '--sequence1', required=True, help="first sequence") 
    parser.add_argument('-b', '--sequence2', required=True, help="second sequence")
    parser.add_argument('-c', '--sequence3', required=True, help="third sequence")
    # The parse_args() method parses the arguments
    args = parser.parse_args()
    print('args:', args)
    # Here, we'll return the arguments as a tuple
    return args.sequence1, args.sequence2, args.sequence3

def cat():
    """
    Concatenate two sequences
    """
    # Assign the values returned from arg_parse to variables
    seq1, seq2, seq3 = arg_parse()
    try:
    	fin1 = open(seq1)
    	fin2 = open(seq2)
    	fin3 = open(seq3)
    except:
    	return -1
    with fin1, fin2, fin3:
    	file1 = fin1.read()
    	file2 = fin2.read()
    	file3 = fin3.read()
    return file1+file2+file3

if __name__ == '__main__':
    print(cat())