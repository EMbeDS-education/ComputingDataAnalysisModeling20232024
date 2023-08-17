
def read_csvfile():
    with open('todo.csv','r') as data_file:
        table = ""
        border = "+" + "-" * 37 + "+\n"
        table += border # print a line
        
        for i, line in enumerate(data_file):
            line = line.strip()
            values = line.split(",")

            if values[2] == '1':
                values[2] = "High"
            elif values[2] == '2':
                values[2] = "Medium"
            elif values[2]== '3':
                values[2] = "Low"

            table+=f"|{values[0]:15}|{values[1]:10}|{values[2]:10}|\n" 
            if i == 0:
                table += border  # print a line

        table += border  # print a line
        return table


print(read_csvfile())
