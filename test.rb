################################################################################################################################################
require 'sqlite3'

class Chef
  def initialize(first_name, last_name, birthday, email, phone, created_at = Time.now, updated_at = Time.now)
    @first_name = first_name
    @last_name = last_name
    @birthday = birthday
    @email = email
    @phone = phone
    @created_at = created_at 
    @updated_at = updated_at
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
          ('Rodrigo', 'Dominguez', '1983-03-12', 'Rodrigo.Do@hotmail.com', '5547896314', DATETIME('now'), DATETIME('now')),
          ('Ortega', 'Olivia', '1995-08-14', 'Olvie.Ort@yahoo.com', '5513226228', DATETIME('now'), DATETIME('now')),
          ('Lauren', 'Ortiz', '1996-02-08', 'Lauren.Ort@eyahoo.com', '5561875128', DATETIME('now'), DATETIME('now')),
          ('Marta', 'Villa', '1988-01-09', 'marta.Villa_2@hotmail.com', '5684768163', DATETIME('now'), DATETIME('now'));
          ('Camila', 'Carson', '1988-01-09', 'Camz.Ort@yahoo.com', '5527301363',DATETIME('now'), DATETIME('now'));
      SQL
    )
  end


  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end
# Podemos usar irb para ejecutar las funciones que acabamos de crear:
# irb(main):004:0> load 'chef.rb'
# => true
# irb(main):005:0> Chef.create_table
# => []
# irb(main):006:0> Chef.seed
# => []

# Verifica desde la consola de Sqlite que se halla creado la tabla y que se halla poblado 
# con los registros que creaste en la función seed. Nuestra base de datos se llama chefs.db.


#Resultado Arrojado 

# CodeaCamp03s-Mac-mini:Juntando Fuerzas, Ruby Y Sql codea_mac_03$ sqlite3 chefs.db
# -- Loading resources from /Users/codea_mac_03/.sqliterc

# SQLite version 3.8.5 2014-08-15 22:37:57
# Enter ".help" for usage hints.
# sqlite> SELECT * FROM chefs
#    ...> ;
# id          first_name  last_name   birthday    email                     phone        created_at           updated_at         
# ----------  ----------  ----------  ----------  ------------------------  -----------  -------------------  -------------------
# 1           Ferran      Adriá      1985-02-09  ferran.adria@elbulli.com  42381093238  2016-07-20 16:44:46  2016-07-20 16:44:46
# 2           Rodrigo     Dominguez   1983-03-12  Rodrigo.Do@hotmail.com    5547896314   2016-07-20 16:44:46  2016-07-20 16:44:46
# 3           Ortega      Olivia      1995-08-14  Olvie.Ort@yahoo.com       5513226228   2016-07-20 16:44:46  2016-07-20 16:44:46
# 4           Lauren      Ortiz       1996-02-08  Lauren.Ort@eyahoo.com     5561875128   2016-07-20 16:44:46  2016-07-20 16:44:46
# 5           Marta       Villa       1988-01-09  marta.Villa_2@hotmail.co  5684768163   2016-07-20 16:44:46  2016-07-20 16:44:46

# Paso 3: ORM
# Crea una función para inicializar (initialize) un Chef con todos sus atributos.

# Vamos a crear funciones para ejecutar la mayoría de los comandos que usamos en SQL, desde Ruby.

# Fíjate la correspondencia que existe entre SQL y las funciones que vas a crear:

 def self.all
    puts "[first_name, last_name, birthday, email, phone, created_at, updated_at]"
    Chef.db.execute(
      <<-SQL
      
      SELECT * FROM chefs;
    SQL
    ) do |row| p row
    end

  end

  def self.where(column_name, value)

    if @column_name =='id'
      @value.to_i
    else
      @vale.to_s
    end

    Chef.db.execute(
      <<-SQL
      SELECT * FROM chefs
      WHERE "#{column_name}" = "#{value}";
    SQL
    ) do |row| p row
    end

  end

  def self.insert(first_name_in, last_name_in, birthday_in, email_in, phone_in)
    Chef.db.execute(
      <<-SQL
        INSERT INTO chefs
          (first_name, last_name, birthday, email, phone, created_at, updated_at)
        VALUES
          ("#{first_name_in}", "#{last_name_in}", "#{birthday_in}", "#{email_in}", "#{phone_in}", DATETIME('now'), DATETIME('now'));
          
      SQL
    )
  end

  def self.delete(column_name, value)

    if @column_name =='id'
      @value.to_i
    else
      @value.to_s
    end
    Chef.db.execute(
      <<-SQL
        DELETE FROM chefs
        WHERE "#{column_name}" = "#{value}";
      SQL
    )
  end

  def self.update(column_name, value, column_update, value_update)

    if @column_name =='id'
      @value.to_i
    else
      @value.to_s
    end
    Chef.db.execute(
      <<-SQL
        UPDATE chefs
        SET "#{column_update}" = "#{value_update}", updated_at = DATETIME('now')
        WHERE "#{column_name}" = "#{value}";
      SQL
    )
  end



  private

  def self.db
    @@db ||= SQLite3::Database.new("chefs.db")
  end

end




line = ARGV
command = line.slice!(0)

case command
  when "all" then Chef.all
  when "create_table" then Chef.create_table
  when "seed" then Chef.seed
  when "select_all" then Chef.where(line[0],line[1])
  when "insert" then Chef.insert(line[0],line[1],line[2],line[3],line[4])
  when "delete" then Chef.delete(line[0],line[1])
  when "update" then Chef.update(line[0],line[1],line[2],line[3])
end