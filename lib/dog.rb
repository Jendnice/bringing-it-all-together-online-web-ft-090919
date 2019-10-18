class Dog 
  
  attr_accessor :id, :name, :breed 
  
  def attributes(id:=nil, name:, breed:)
    @id = id 
    @name = name
    @breed = breed 
  end 
  
end 