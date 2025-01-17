# models/testing.rb
class Testing < ActiveRecord::Base
  # This model will automatically map to the `testing` table in your database

  # Optional: Define any custom methods to interact with the database

  # Example: Method to fetch all records from `testing` table
  def self.all_records
    self.all  # ActiveRecord's built-in method to get all records
  end

  # Example: Custom SELECT query
  def self.custom_query
    puts "COMMING IN CUSTOM QUERY"
    result = ActiveRecord::Base.connection.exec_query("SELECT * FROM testings")
    result.map { |row| row }
  end
end
