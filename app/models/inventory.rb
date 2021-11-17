class Inventory < ApplicationRecord

  def self.to_xlsx(records)
    export_fields = ["name"]
    SpreadsheetService.new.generate(export_fields, records)
  end

  def self.import_preview(file)
    create_record = []

    spreadsheet = SpreadsheetService.new.parse(file)
    headers = spreadsheet.row(1)
    (2..spreadsheet.last_row).each do |i|
      row = Hash[[headers, spreadsheet.row(i).map(&:to_s)].transpose]
      inventory = new
      inventory.abid = row["Ab ID"]
      inventory.size = row["Size"]
      inventory.unit = row["Unit"]
      inventory.fridge = row["Fridge"]
      create_record << inventory
    end
    create_record
  end
end
