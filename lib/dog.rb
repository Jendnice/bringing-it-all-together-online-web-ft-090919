class Dog 
  
  attr_accessor :id, :name, :breed 
  
  def initialize(attributes)
    attributes.each {|key, value| self.send(("#{key}="), value)}
    self.id ||= nil 
  end 
  
  def self.create_table
    sql = <<-SQL
    CREATE TABLE IF NOT EXISTS dogs (
      id INTEGER PRIMARY KEY,
      name TEXT,
      breed TEXT
    );
    SQL
    
    DB[:conn].execute(sql)
  end 
  
  def self.drop_table
    sql = <<-SQL 
     DROP TABLE dogs 
    SQL
    
    DB[:conn].execute(sql)
  end 
  
  def self.new_from_db(row)
    attributes = {
      :id => row[0],
      :name => row[1],
      :breed => row[2]
    }
    new_dog = Dog.new(attributes)
  end 
  
  def self.find_by_name(name)
    sql = <<-SQL
      SELECT * 
      FROM dogs 
      WHERE name = ?
    SQL
    
    result = DB[:conn].execute(sql, name)[0]
    Dog.new_from_db(result)
  end 
  
  def update 
    sql = "UPDATE dogs SET name = ?, breed = ?, WHERE breed = ?"
    DB[:conn].execute(sql, self.name, self.breed, self.id)
  end 
  
  def save 
    if self.id 
      self.update 
    else 
      sql = <<-SQL
        INSERT INTO dogs (name, breed)
        VALUES (?, ?)
      SQL
      
      DB[:conn].execute(sql, self.name, self.breed)
      @id = DB[:conn].execute("SELECT last_insert_rowid() FROM dogs")[0][0]
    end 
    self
  end 
  
  def self.create(attributes) 
    dog = Dog.new(attributes)
    dog.save
    dog
  end 
  
  def self.find_by_id(id)
    sql = <<-SQL
      SELECT * 
      FROM dogs
      WHERE id = ?
    SQL
    
    result = DB[:conn].execute(sql, id)[0]
    Dog.new_from_db(result)
  end 
  
  # def self.find_or_create_by(name:, album:)
  #   song = DB[:conn].execute("SELECT * FROM songs WHERE name = ? AND album = ?", name, album)
  #   if !song.empty?
  #     song_data = song[0]
  #     song = Song.new(song_data[0], song_data[1], song_data[2])
  #   else
  #     song = self.create(name: name, album: album)
  #   end
  #   song
  # end
  
  def self.find_or_create_by(name:, breed:)
   dog = DB[:conn].execute("SELECT * FROM dogs WHERE name = ? AND breed = ?", name, breed)
   if !dog.empty?
     dog_data = dog[0]
     dog = Dog.new(dog_data)
   else 
     attributes = {
      :name => name,
      :breed => breed
      }
     dog = self.create(attributes)
   end 
   dog 
  end 
  
end 