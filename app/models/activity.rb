class Activity < ApplicationRecord
  def self.title
    last.name
  end

  def self.desc
    last.desc
  end

  def self.time
    last.date
  end

  def self.address
    last.address
  end
end
