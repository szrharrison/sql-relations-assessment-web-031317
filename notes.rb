# Copy/ Paste Your Customer, Owner, Restaurant, and Review Classes Here
######################################################
# Begin Class Customer
######################################################
class Customer
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    birth_year: "INTEGER",
    hometown: "TEXT"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id
  ######################################################
  def reviews
    sql = <<-SQL
      SELECT * FROM reviews
      WHERE customer_id = ?
    SQL

    self.class.db.execute( sql, self.id )
  end

  def restaurants
    sql = <<-SQL
      SELECT restaurants.* FROM restaurants
      INNER JOIN reviews ON reviews.restaurant_id = restaurants.id
      WHERE reviews.customer_id = ?
    SQL
    self.class.db.execute(sql, self.id)
  end
end

######################################################
# Begin Class Owner
######################################################
class Owner
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods
  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id
  ######################################################
  def restaurants
    sql = <<-SQL
      SELECT * FROM restaurants
      WHERE owner_id = ?
    SQL

    self.class.db.execute( sql, self.id )
  end
end

######################################################
# Begin Class Restaurant
######################################################
class Restaurant
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    name: "TEXT",
    location: "TEXT",
    owner_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id
  ######################################################
  def owner
    sql = <<-SQL
      SELECT * FROM owners
      WHERE id = ?
    SQL

    self.class.db.execute( sql, self.owner_id )
  end
end

######################################################
# Begin Class Review
######################################################
class Review
  include Databaseable::InstanceMethods
  extend Databaseable::ClassMethods

  ATTRIBUTES = {
    id: "INTEGER PRIMARY KEY",
    customer_id: "INTEGER",
    restaurant_id: "INTEGER"
  }

  attr_accessor(*self.public_attributes)
  attr_reader :id
  ######################################################
  def customer
    sql = <<-SQL
      SELECT * FROM customers
      WHERE id = ?
    SQL

    self.class.db.execute( sql, self.customer_id )
  end

  def restaurant
    sql = <<-SQL
      SELECT * FROM restaurants
      WHERE id = ?
    SQL

    self.class.db.execute( sql, self.restaurant_id )
  end
end
