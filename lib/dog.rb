class Dog 
  
  attr_accessor :id, :name, :breed 
  
  def attributes(id:, name:, breed:)
    @id = id 
    @name = name
    @breed = breed 
  end 
  
end 