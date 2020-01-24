import csv
import xlsxwriter

with open('Chinook_Track.csv') as csv_file:
    csv_reader = csv.reader(csv_file, delimiter=',')
    line_count = 0
    # create workbook and add worksheet
    workbook = xlsxwriter.Workbook('test.xlsx')
    worksheet = workbook.add_worksheet()
    row = 0
    artists = []
    for line in csv_reader:
        if line[5] != "NULL":
            artists.append(line[5])
        line_count += 1

    print(f'Processed {line_count} lines.')

    # Remove duplicate and write xlx file
    for i in list(set(artists)):
        worksheet.write(row, 0, i)
        row += 1

    # close file
    workbook.close()



