=begin
#Open Class
#Mo dify an e x is t in g c las s .
class String
def my_string_method
"my method"
end
end
"abc".my_string_method # => "my method"


#class macros
class C; end
class << C
def my_macro(arg)
"my_macro(#{arg}) called"
end
end
class C
my_macro :x # => "my_macro(x) called"
end

#Ghost method
class C
def method_missing(name, *args)
name.to_s.reverse
end
end
obj = C.new
obj.my_ghost_method # => "dohtem_tsohg_ym"

#dynamic method
class C
end
C.class_eval do
define_method :my_method do
"a dynamic method"
end
end
obj = C.new
obj.my_method # => "a dynamic method"

#singletone method
obj = "abc"
class << obj
def my_singleton_method
"x"
end
end
obj.my_singleton_method # =

#Symbol to Proc
[1, 2, 3, 4].map(&:even?) # => [false, true, false, true]
=end



class NifNif
  def name= p
    @name = p
  end

  def name
    @name 
  end

  def surname= p
    @surname = p
  end

  def surname
    @surname 
  end

  def song= p
    @song = p
  end

  def song
    @song 
  end
end

pig1 = NifNif.new
pig1.name = 'Nif-Nif'
pig1.surname = 'Bacon'

puts pig1.name		#=> Nif-Nif
puts pig1.surname	#=> Bacon
puts


class NafNaf

  def self.attribute_accessor attribute
    define_method "#{attribute}=" do |p|
      instance_variable_set "@#{attribute}", p
    end

    define_method attribute do 
      instance_variable_get "@#{attribute}"
    end
  end

  attribute_accessor :name
  attribute_accessor :surname
  attribute_accessor :song

end

pig2 = NafNaf.new
pig2.name = 'Naf-Naf'
pig2.surname = 'Bacon'

puts pig2.name		#=> Naf-Naf
puts pig2.surname	#=> Bacon

class NufNuf

  def self.attribute_accessor attribute
    define_method "#{attribute}=" do |p|
      instance_variable_set "@#{attribute}", p
    end

    define_method attribute do 
      instance_variable_get "@#{attribute}"
    end
  end

  def self.attribute_accessors *attributes
    attributes.each do |attribute|
      attribute_accessor attribute
    end
  end

  attribute_accessors :name, :surname, :song


end

pig3 = NufNuf.new
pig3.name = 'Nuf-Nuf'
pig3.surname = 'Bacon'

puts pig3.name		#=> Nuf-Nuf
puts pig3.surname	#=> Bacon
puts


class Ghost
  def scare
    'Boo!'
  end

  def cry
    'Waaaaaghhhhh!'
  end
end

class GhostyGhost
  def method_missing arg
    if arg == :cry
      'Waaaaaaghhhhh!'
    elsif arg == :scare
      'Boo!'
    else 
      super arg
    end
  end
end

ghost = GhostyGhost.new
puts ghost.cry 	#=> Waaaaaaghhhhh!
puts ghost.scare 	#=> Boo!
puts

class Boy
  def method_missing arg
    arg == :fly ? "boys can't fly" : super(arg)
  end
end

bobby = Boy.new
def bobby.fly
  'but Bobby is special'
end

regular_boy = Boy.new
puts regular_boy.fly 	#=> boys can't fly
puts bobby.fly 		#=> but Bobby is special
puts

class AnotherPig
  def self.attribute_writer attribute
    define_method "#{attribute}=" do |p|
      instance_variable_set "@#{attribute}", p
    end
  end
end

def AnotherPig.attribute_reader attribute
  define_method attribute do 
    instance_variable_get "@#{attribute}"
  end
end

class AnotherPig
  attribute_writer :name
  attribute_reader :name
end

misterious_pig = AnotherPig.new
misterious_pig.name = 'Funtik'
puts misterious_pig.name 	#=> Funtik
puts


class Man
  def initialize p = {}
    @name = p[:name]
    @occupation = p[:occupation]
  end

  def world_around
    binding
  end

  def about
    "My name is #{@name} and no #{self.class.to_s.downcase} love #{@occupation} like I do!"
  end
end

buddy = Man.new :name => 'Burny', :occupation => 'parties'
puts eval('about', buddy.world_around) 	#=> My name is Burny and no man love parties like I do!
puts


class Ninja
  def train
    'traning'
  end
end

jim = Ninja.new
puts jim.train	#=> traning


Ninja.class_eval do
  def swing
    'swinging'
  end
end

puts jim.swing	#=> swinging

other_jumper = 'grasshopper'
Ninja.class_eval do
  define_method :jump do
    "jumping like a #{other_jumper}"
  end	  
end

puts jim.jump	#=> jumping like a grasshopper
puts

jim.instance_eval do
  def sneak
    'sneaking'
  end
end

puts jim.sneak #=> 'sneaking'

other_mover = 'cat'
jim.instance_eval do
  @other_mover = other_mover
  def move 
    "moving like a #{@other_mover}"
  end
end

puts jim.move		#=> 'moving like a cat'


Ninja.instance_eval do
  def stub
    'stub'
  end
end

puts Ninja.stub #=> stub


Ninja.instance_eval do
  define_method :run do
    'running'
  end

  puts self.name #=> Ninja
end

puts jim.run #=> 'running'

