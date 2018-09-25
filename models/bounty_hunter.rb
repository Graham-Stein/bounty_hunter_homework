
require('pg')
require('pry')

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

  def update()
      db = PG.connect({
        dbname: 'bounty_hunters',
        host: 'localhost'
        })

      sql = "
      UPDATE  bounty_hunters
      SET (
        name,
        species,
        danger,
        homeworld
      ) = ( $1, $2, $3, $4)
      WHERE id = $5;
      "
      values = [
        @name,
        @species,
        @danger,
        @homeworld,
        @id
      ]
      db.prepare('update', sql)
      db.exec_prepared('update', values)
      db.close()

    end

  def self.all()
    db = PG.connect({
      dbname: 'bounty_hunters',
      host: 'localhost'
    })
    sql = "
      SELECT * FROM bounty_hunters;
    "
    db.prepare('all', sql)
    mark_hashes = db.exec_prepared('all')
    db.close()
    # binding.pry
    mark_objects = mark_hashes.map do |mark_hash|
      BountyHunter.new(mark_hash)
    end
    return mark_objects

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
