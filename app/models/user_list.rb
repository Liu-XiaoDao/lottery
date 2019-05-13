class UserList < ApplicationRecord
  #default_scope { order(id: :desc) }
  #belongs_to :leader, class_name: "UserList"

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
      user_list = new
      user_list.attributes = row.to_hash.slice(*["name"])
      create_record << user_list
    end
    create_record
  end
end
