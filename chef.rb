require 'rubygems'
require 'sqlite3'


class Chef
  attr_accessor :first_name, :last_name, :birthday, :mail, :hone, :created_at, :updated_at
  def initialize (first_name, last_name, birthday, email, phone, created_at, updated_at)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
    @created_at = Time.now
    @updated_at = Time.now
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
          ('Ferran', 'Adriá', '1985-02-09', 'ferran.adria@elbulli.com', '42381093238', DATETIME('now'), DATETIME('now')),
          ('Humberto', 'González', '1979-05-14', 'h_glez@gmail.com', '423810931312', DATETIME('now'), DATETIME('now')),
          ('Ximena', 'Hernadez', '1982-08-10', 'xoxo@yahoo.com', '433810931212', DATETIME('now'), DATETIME('now')),
          ('Ana', 'Ramirez', '1983-03-03', 'ana@hotmail.com', '523810931312', DATETIME('now'), DATETIME('now'));
        -- Añade aquí más registros
      SQL
    )
  end 

  # A partir de esta línea  es que comenzamos a hacer las consultas de la base de datos que ya creamos
  def self.all
     Chef.db.execute(
      <<-SQL
      SELECT * FROM chefs;
      SQL
    )
  end

  def self.where(column, value)
    
     Chef.db.execute(
      #<<-SQL 
      "SELECT * FROM chefs WHERE #{column} = ?", value
      #SQL
    )
  end


 def save
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ('#{@first_name}', '#{@last_name}', '#{@birthday}', '#{@email}', '#{@phone}', '#{@created_at}', '#{@updated_at}');          
      SQL
    )

  end


def self.delete(column, value)
   
     Chef.db.execute(
      #<<-SQL 
      "DELETE FROM chefs WHERE #{column} = ?", value
      #SQL
    )
  end


  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end

  #Chef.all
  
  #agregamos este código para ver lo que está imprimiendo, aunque no es necesario
  #p Chef.where('first_name', 'Ferran')
#p Chef.where('id', 2)
#chef = Chef.new('MartinN', 'De la Rosa', '2000-01-03', 'goma@gmail.com', '623410931312', Time.now, Time.now) 

# la siguiente línea es para correr este archvio en terminal y arroja un [], lo que quiere decir, que ya incluyó los datos
#p chef.save

# Código para borrar desde terminal 
#p Chef.delete('first_name', 'Ferran')


