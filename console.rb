require_relative('./models/bounty_hunter.rb')
require('pry')

BountyHunter.delete_all()

mark1 = BountyHunter.new({
  "name" => "Han Solo",
  "species" => "Humanoid",
  "danger" => "3",
  "homeworld" => "Hoth"
  })

mark2 = BountyHunter.new({
  "name" => "Luke Skywalker",
  "species" => "Humanoid",
  "danger" => "3",
  "homeworld" => "Tatooine"
  })

mark3 = BountyHunter.new({
  "name" => "Chewbacca",
  "species" => "Wookie",
  "danger" => "4",
  "homeworld" => "Wookie-World"
  })

  mark1.save()
  mark2.save()
  mark3.save()


  mark1.danger = 4
  mark1.update()

  marks = BountyHunter.all()
  puts marks[0].name
  puts marks[0].id
  puts marks[0].species
  puts marks[0].danger

  found = BountyHunter.find(141)
  puts "#{found} is the found item"
  puts found.each { |attribute| puts attribute.to_s}
