class Pokemon
  @@all = []
  attr_accessor :id, :name, :type, :db, :hp

  def initialize(id:, name:, type:, hp: nil, db:)
    @id = id
    @name = name
    @type = type
    @db = db
    @hp = hp
    @@all << self
  end

  def self.save(name, type, db)
    db.execute("INSERT INTO pokemon (name, type) VALUES (?, ?)", name, type)
  end

  ## The find method creates a new Pokemon after selecting their row from the database by their id number.
  def self.find(id, db)
    pkmn = db.execute("SELECT * FROM pokemon WHERE id = ?", id).flatten
    Pokemon.new(id: pkmn[0], name: pkmn[1], type: pkmn[2], hp: pkmn[3], db: db)
  end

  def alter_hp(hp, db)
    db.execute("UPDATE pokemon SET hp = ? WHERE id = ?", hp, self.id)
  end

end
