#Color codes taken from: https://gist.github.com/abritinthebay/d80eb99b2726c83feb0d97eab95206c4
reset = "\x1b[0m"
red = "\x1b[31m"
green = "\x1b[32m"
BGblack = "\x1b[40m"
BGyellow = "\x1b[43m"
BGgray = "\x1b[100m"

def print_green(msg):
    print(BGyellow+green+ msg +reset)

def print_red(msg):
    #print(BGblack+red+ msg +reset)    
    #print(BGgray+red+ msg +reset)    
    print(red+ msg +reset)

def print_testname(msg):
    print('\x1b[36m\x1b[4m\x1b[1m'+ str(msg) +reset)

#These two functions replace 'input()'
def my_read_list(lst_param):
    for i in lst_param:
        yield i

def my_input(*args, **kwargs):
    return next(_inputs_provider)


#Store the original function for 'input()'
from ipykernel.ipkernel import IPythonKernel
ipython_input = IPythonKernel._input_request


#Store the original function for 'print()'
import sys
ipython_output = sys.stdout


#Library to print information on exceptions
import traceback


#Test each line from expected/actual output
def test_outputs(file_out,expected_output):
    passed=True
    with open(file_out) as f:
        actual_output = f.readlines()
    lines_to_compare=min(len(actual_output),len(expected_output))
    correct_num_lines=True
    if len(actual_output)!=len(expected_output):
        correct_num_lines=False
        print_red(' Test FAILED!')
        print_red('  The program should print '+str(len(expected_output))+' lines while there are '+str(len(actual_output)))
        print_red('  Nevetheless, we compare the first '+str(lines_to_compare)+' lines')
        print()
    else:
        print_green(' The program prints '+str(len(expected_output))+' lines as expected.')
        print()
    for i in range(lines_to_compare):
        print('  Line',i)
        _passed=assert_equals(actual_output[i],expected_output[i])
        passed=passed and _passed
    if correct_num_lines and passed:
        print_green('Test PASSED!')
    else:
        print_red('Test FAILED!')

        
def assert_equals(actual,expected,failure_message=""):
    passed=True
    if actual != None and type(actual)==str:
        actual=actual.strip()
    if expected != None and type(expected)==str:        
        expected=expected.strip()
    if(expected==actual):
        #print('Test passed')
        print_green('  Expected and actual output match:\n  '+str(expected))
    else:
        passed=False
        print_red('  Test FAILED')
        print_red('    Expected: '+str(expected))
        print_red('    Actual  : '+str(actual))
        if(failure_message!=""):
            print(failure_message)
    print()
    return passed
    
    
#Run the assignment of the student, and test its output
def run_and_test(inputs,expected_outputs,asgn,title="",file_out="stdout.txt"):
    global _inputs_provider
    exception_generated=False
    if len(title)==0:
        title=str(inputs)
    try:
        try:
            #Replace input() with my_input()
            IPythonKernel._input_request = my_input
            _inputs_provider=my_read_list(inputs)

            #Write in a file rather than in the terminal
            sys.stdout = open(file_out, 'w')

            #Run the code of the student
            asgn()

        finally:
            #Restore the correct input() and print()
            IPythonKernel._input_request = ipython_input
            sys.stdout = ipython_output
            print_testname(f'Test {title}')
    except StopIteration as err:
            exception_generated=True
            print_red(' You are making too many `input()`. Please check your code.')
            print_red(' The problem arised executing the following command:')
            #raise err
            traceback.print_exc(limit=2)

    if not(exception_generated):
        #assert_equals("abc","abc")
        #assert_equals("abc","abcd")
        test_outputs(file_out,expected_outputs)
        
        
        

#Run the assignment of the student, and test its output
def run_and_test_func(inputs,expected_outputs,asgn,more_params=False,title=""):
    exception_generated=False
    if len(title)==0:
        title=str(inputs)
    all_passed=True
    for (i,o) in zip(inputs,expected_outputs):
        print_testname(f'Test {i}')
        if more_params:
            passed=assert_equals(asgn(*(i)),o)
        else:
            passed=assert_equals(asgn(i),o)
        all_passed=all_passed and passed
    if all_passed:
        print_green('Test PASSED!')
    else:
        print_red('Test FAILED!')        