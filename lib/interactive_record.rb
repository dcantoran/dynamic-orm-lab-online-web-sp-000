require_relative "../config/environment.rb"
require 'active_support/inflector'

class InteractiveRecord
  def self.table_name
    self.to_s.downcase.pluralize
  end 
  
  def self.column_names 
    
    DB[:conn].results_as_hash = true 
    
    sql = "pragma table_info('#{table_name}')"
    
    table_info = DB[:conn].execute(sql)
    col_names = []
    table_info.each do |row|
      col_names << row["name"]
    end 
    col_names.compact
  end 
  
  def initialize(options = {})
    options.each do |prop, val|
      self.send("#{prop}=", val)
    end 
  end 
  
end