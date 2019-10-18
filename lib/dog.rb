class Dog 
  
  attr_accessor :id, :name, :breed 
  
  # def attributes(id: nil, name: , breed: )
     
  # end 
  
  def initialize(attributes)
    #id: nil, name:, breed:
    attributes.each {|key, value| self.send(("#{key}="), value)}
    self.id ||= nil
  end
  
end 