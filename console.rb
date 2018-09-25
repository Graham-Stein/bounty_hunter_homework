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
