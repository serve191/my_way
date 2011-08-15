
require 'rubygems'
require 'sinatra'
require 'erb'


def select_random some_list
    if some_list.empty?
        return nil
    end
    some_list[rand(some_list.length)]
end



while
end
ifelse?




people = Hash.new  
people[:nickname] = 'IndianGuru'  
people[:language] = 'Marathi'  
people[:lastname] = 'Talim'  
  
puts people[:lastname] # Talim  

a = Hash["name" => "Jhon", "age" => "30","sex" => "m"]   # Hash.[] Create a new empty hash 
# Create a new initialized hash 
b = Hash.[]("name", "Markus", "age", "43","sex", "m")
c = Hash.[]("name" => "Ash", "age" => "16", "sex" => "w")
d = Hash["name", "Cris", "age", "25","sex", "m"]
e = Hash["name" => "Mary", "age" => "20","sex" => "w"]
f = {"name", "Bary", "age", "22","sex", "m"}
g = {"name" => "Rebeca", "age" => "27","sex" => "w"}
h = Hash["name" => "Erika", "age" => "24","sex" => "w"]
i = Hash["name" => "Jake", "age" => "18","sex" => "m"]
j = Hash["name" => "Jona", "age" => "30","sex" => "w"]
k = Hash["name" => "Andy", "age" => "26","sex" => "m"]
l = Hash["name" => "Red", "age" => "56","sex" => "m"]
m = Hash["name" => "mr.Gold", "age" => "31","sex" => "m"]
n = Hash["name" => "poule", "age" => "37","sex" => "m"]
o = Hash["name" => "katrin", "age" => "28","sex" => "w"]





get '/bik' do
     greeting =  people[:nickname]
     @name = 'name'
     @age = 'age'
     @sex = 'sex'
@raw02 = a["name"] 
     @raw12 = a["age"]
     @raw22 = a["sex"]
@raw03 = b["name"]
     @raw13 = b["age"] 
     @raw23 = b["sex"]
@raw04 = c["name"]
     @raw14 = c["age"]
     @raw24 = c["sex"]
@raw05 = d["name"]
     @raw15 = d["age"]
     @raw25 = d["sex"]
@raw06 = e["name"]
     @raw16 = e["age"]
     @raw26 = e["sex"]
@raw07 = f["name"]
     @raw17 = f["age"]
     @raw27 = f["sex"]
@raw08 = g["name"]
     @raw18 = g["age"]
     @raw28 = g["sex"]
@raw09 = h["name"]
     @raw19 = h["age"]
     @raw29 = h["sex"]
@raw010 = i["name"]
     @raw110 = i["age"]
     @raw210 = i["sex"]
@raw011 = j["name"]
     @raw111 = j["age"]
     @raw211 = j["sex"]
@raw012 = k["name"]
     @raw112 = k["age"]
     @raw212 = k["sex"]
@raw013 = l["name"]
     @raw113 = l["age"]
     @raw213 = l["sex"]
@raw014 = m["name"]
     @raw114 = m["age"]
     @raw214 = m["sex"]
@raw015 = n["name"]
     @raw115 = n["age"]
     @raw215 = n["sex"]
@raw016 = o["name"]
     @raw116 = o["age"]
     @raw216 = o["sex"]
     
     erb :index, :locals => {:greeting => greeting}
     

   end



post '/' do
    main_courses = [ 'pancakes', 'waffles' ]
    sides = [ 'potatoes', 'eggs', 'fruit salad' ]
    beverages = [ 'orange juice', 'grapefruit juice', 'coffee']

    breakfast = {}
    breakfast[:main] = select_random main_courses
    breakfast[:side] = select_random sides
    breakfast[:beverage] = select_random beverages

    erb :breakfast, :locals => {:breakfast => breakfast}
end
