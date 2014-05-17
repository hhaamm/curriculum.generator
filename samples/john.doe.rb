# coding: utf-8
require './../generator.rb'

c = Curriculum.build {
  self.name= "John Doe"
  self.city= "Chicago"
  self.country= "EE.UU."
  born_in 1989
  
  work("Google") do
    from(2008).to(:year => 2009, :month => 7)

    sample "Google page", :url => "http://www.google.com.ar"

    desc :en, "I worked on Google doing improving the searcher algorithm"

    tech "Python", :months => 2
    tech "Java", :months => 5
    
    tool "Eclipse"   
  end
  
  work("Facebook") {
    desc :en, "I worked on Facebook improving the social network"
    from(:year => 2009, :month => 8).to(2011)
    
    tech "PHP"
    tool "CakePHP"

    tech "Python", :years => 1
  }
}

puts c.cover_letter("Python")
