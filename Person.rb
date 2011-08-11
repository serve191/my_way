require 'rubygems'
require 'sinatra'

 class Person                

 #  include Comparable        
 #  @@count_obj = 0           
                             
                             
   def initialize(name, age, sex) 
                             
     @name, @age, @sex = name, age, sex 
#     @@count_obj += 1
   end
 
   def <=>(person)           
                             
     @age <=> person.age     
   end
 
   def to_s                  
     "#{@name} (#{@age}) #{@sex}"    
   end
                          
   attr_reader :name, :age, :sex
 end
                         
 group = [ Person.new("John", 20, 'M'),
          Person.new("Markus", 63, 'M'),
          Person.new("Ash", 16, 'W'),
          Person.new("Cris", 31,'M'),
          Person.new("Mary", 29,'W'),
          Person.new("Bary", 21,'M'),
          Person.new("Rebeca", 28,'W'),
          Person.new("Erika", 24,'W'),
          Person.new("Jake", 18,'M'),
          Person.new("Jona", 30,'W'),
          Person.new("Andy", 26,'M'),
          Person.new("Red", 22,'M')]
                      
 puts group.sort
File.new('Person.txt', 'w')
File.open('Person.txt', 'a') {|file|
   file.puts group.sort
     } 


#end

#for value in [1,2,3,4,5,6,7,8,9,10]
#print File.open('book.txt', 'a') {|file|
#   file.puts 'Wrote some text.'
#     } 

#end



#"#{value} "

  # def inspect               
   #  "<#{@@count_obj}:#{to_s}>"
   #end

