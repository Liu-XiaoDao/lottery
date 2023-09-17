class SpreadsheetService
  def parse(file)
    case File.extname(file.original_filename)
    when ".csv" then Roo::CSV.new(file.path)
    when ".xls" then Roo::Excel.new(file.path, nil, :ignore)
    when ".xlsx" then Roo::Excelx.new(file.path, nil, :ignore)
    else raise "Unknown file type: #{file.original_filename}"
    end
  end

  def generate(fields, records)
    workbook = RubyXL::Workbook.new
    worksheet = workbook[0]

    fields.each_with_index do |field, col|
      worksheet.add_cell(0, col, field)
      worksheet.sheet_data[0][col].change_font_bold(true)
      worksheet.change_column_width(col, 15)
    end

    worksheet.change_row_height(0, 18)

    row_index = 1

    records.each_with_index do |record, row|

      fields.each_with_index do |field, col|
        worksheet.add_cell(row_index, col, record.send(field).to_s).change_fill(row%2 == 0 ? 'F0FFFF':'FAFFF0')
      end
      worksheet.change_row_height(row_index, 18)
      row_index = row_index + 1

      record.families.each_with_index do |family, r|
        fields.each_with_index do |field, col|
          worksheet.add_cell(row_index, col, family.send(field).to_s).change_fill(row%2 == 0 ? 'F0FFFF':'FAFFF0')
        end
        row_index = row_index + 1
      end
    end

    workbook
  end
end
