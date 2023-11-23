import os.path

def add_item_to_do_list():
    """
    Asks users to keep entering items to add to a new To Do list until they enter the word 'stop'
    :return: to do list with new items
    """
    to_do_list = []
    while True:
        item = input("Add item (add 'stop' to finish): ")
        if item.lower() == "stop": #if input is "stop" break
            break

        to_do_list.append(item)

    return to_do_list

def get_new_to_do_filename():
    """
    Asks users to enter a filename for their new To Do file.
    The user must enter a filename that contains at least one letter followed by '.txt'.
    The user should be repeatedly prompted for a filename until a valid one is entered.
    :return: To Do filename
    """
    while True:
        to_do_list_file = input("Enter To Do List Filename (at least one letter followed by '.txt' ): ")

        # Extension 1: Add validation
        if len(to_do_list_file.strip().split(".")[0]) > 0 and to_do_list_file.lower().endswith("txt"):
            break
    return to_do_list_file

def write_to_do_file(to_do_list_file, to_do_list):
    """
    Writes all of the items in the list to the user's To Do file (each item on a new line)
    :param to_do_list_file: To Do filename
    :param to_do_list: To Do List to save
    """
    with open(to_do_list_file, "a") as my_file:
        for it in to_do_list:
            my_file.write(it + "\n")

def get_to_do_filename():
    """
     Asks users to enter a filename od an existing To Do file.
     The user should be repeatedly prompted for a filename until a existing one is entered.
     Use os.path.isfile(to_do_list_file) to check if to_do_list_file exists
    :return: the existing To Do filename
    """
    to_do_list_file = ""
    while not os.path.isfile(to_do_list_file):
            to_do_list_file = input("Enter Filename to open: ")

    return to_do_list_file

def read_to_do_list(to_do_list_file):
    """
    Load a To Do file into a python list
    :param to_do_list_file: To Do file to open
    :return: to_do_list contains items of to_do_list_file
    """
    to_do_list = []
    with open(to_do_list_file, "r") as my_file:
        to_do_list = my_file.read().split()

    return to_do_list

def get_option():
    """
    Asks users to select 1 or 2 option
    :return: the option selected by users (1 or 2)
    """
    while True:
        choice = input("Select Option [1 or 2] [ENTER] ")
        if choice in  ["1", "2"]:
            break
    return choice

if __name__ == "__main__":
    print("""\
    Plese select:
        1. Open and display the contents of an existing to do list file
        2. Enter items to add to a new to do list file    
      """)
    choice = get_option()
    if choice == "1": # Open and display the contents of an existing to do list file
        to_do_list_file = get_to_do_filename() # get an existing to do list file
        to_do_list = read_to_do_list(to_do_list_file) # load to do list
        print(to_do_list) # display the contents of to do list

    elif choice == "2":# Enter items to add to a new to do list file
        to_do_list = add_item_to_do_list() #get to do list
        to_do_list_file = get_new_to_do_filename() # get to do list file
        write_to_do_file(to_do_list_file, to_do_list) # writes to do list into to do list file
