
require('pg')

class BountyHunter

  attr_reader :id
  attr_accessor :name, :species, :danger, :homeworld

  def initialize(details)
    @id = details['id'].to_i
    @name = details['name']
    @species = details['species']
    @danger = details['danger'].to_i
    @homeworld = details['homeworld']
  end

  def self.delete_all()
    sql = "DELETE FROM bounty_hunters;"
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
    })
    db.exec(sql)
    db.close
  end


  def save()
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
    })

    sql = "
    INSERT INTO bounty_hunters (
      name,
      species,
      danger,
      homeworld
    )
    VALUES ($1, $2, $3, $4)
    RETURNING id;
    "
    db.prepare('save', sql)
    result = db.exec_prepared('save', [
      @name,
      @species,
      @danger,
      @homeworld
    ])
    db.close
    result_hash = result[0]
    string_id = result_hash['id']
    id = string_id.to_i
    @id = id
  end

end
