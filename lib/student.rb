require 'pry'

class Student
  attr_accessor :name, :grade
  attr_reader :id

  def initialize(name, grade)
    @name = name
    @grade = grade
  end

  def self.create_table
    sql = "CREATE TABLE IF NOT EXISTS students (
      id INTEGER PRIMARY KEY,
      name TEXT,
      grade INTERGER
    );"

    DB[:conn].execute(sql)
  end

  def self.drop_table
    sql = "DROP TABLE IF EXISTS students;"
    DB[:conn].execute(sql)
  end

  def save
    sql = "INSERT INTO students (name, grade) VALUES (?, ?);"

    DB[:conn].execute(sql, self.name, self.grade)
    @id = DB[:conn].execute("SELECT last_insert_rowid() FROM students")[0][0]

  end

  def self.create(name:, grade:)
    new_s = Student.new(name, grade)
    new_s.save
    new_s
  end

end
