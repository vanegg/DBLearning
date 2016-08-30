require 'sqlite3'

class Chef

  def initialize (data)
    @first_name = data[0]    
    @last_name = data[1]
    @birthday = data[2]
    @email = data[3]
    @phone = data[4]
    @created_at = data[5]
    @updated_at = data[6]
  end

  def self.create_table
    Chef.db.execute(
      <<-SQL
        CREATE TABLE chefs (
          id INTEGER PRIMARY KEY AUTOINCREMENT,
          first_name VARCHAR(64) NOT NULL,
          last_name VARCHAR(64) NOT NULL,
          birthday DATE NOT NULL,
          email VARCHAR(64) NOT NULL,
          phone VARCHAR(64) NOT NULL,
          created_at DATETIME NOT NULL,
          updated_at DATETIME NOT NULL
        );
      SQL
    )
  end

  def self.seed
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('Julio', 'Rene', '1970-07-28', 'julio@correo.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Gloria', 'Franco', '1970-06-28', 'gloria@correo.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now'));
      SQL
    )
  end

  def self.all
    Chef.db.execute(
      <<-SQL
        SELECT * FROM chefs;
      SQL
    )
  end

  def self.where(attribute, name)
    Chef.db.execute(
        "SELECT * FROM chefs WHERE #{attribute} = '#{name}';"
    )
  end

  def save
    Chef.db.execute(
      "INSERT INTO chefs (first_name, last_name, birthday, email, phone, created_at, updated_at) VALUES ('#{@first_name}', '#{@last_name}', '#{@birthday}', '#{@email}', '#{@phone}', '#{@created_at}', '#{@updated_at}');"
    )
  end

  def self.delete(attribute, name)
    Chef.db.execute(
        "DELETE FROM chefs WHERE #{attribute} = '#{name}';"
    )    
  end

  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end