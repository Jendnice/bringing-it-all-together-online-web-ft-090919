class Dog 
  
  attr_accessor :id, :name, :breed 
  
  def attributes(id: nil, name: , breed: )
    params = {id: id, name: name, breed: breed}
     def initialize(params)
     @id = id 
     @name = name
     @breed = breed 
     end 
  end 
  
end 