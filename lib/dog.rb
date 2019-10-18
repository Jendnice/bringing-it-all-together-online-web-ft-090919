class Dog 
  
  attr_accessor :id, :name, :breed 
  
  def attributes(name: , breed: , id = nil)
    @id = id 
    @name = name
    @breed = breed 
  end 
  
end 