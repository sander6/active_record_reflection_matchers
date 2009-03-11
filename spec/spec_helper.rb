ENV["RAILS_ENV"] = "test"
require 'active_record'
require 'spec'

Spec::Runner.configure do |config|
  config.include(Sander6::ActiveRecordReflectionMatchers)
end

# Setup for the test database (in-memory SQLite3)

ActiveRecord::Base.silence do
  ActiveRecord::Migration.verbose = false
  ActiveRecord::Base.establish_connection({
    :adapter  => 'sqlite3',
    :database => ':memory:'
  })
  
  ActiveRecord::Schema.define do
    create_table :things do |t|
      t.string :name
    end
    
    create_table :tings do |t|
      t.integer :thing_id, :tong_id
    end
    
    create_table :tongs do |t|
      t.string :name
    end
    
    create_table :tings_tongs, :id => false do |t|
      t.integer :ting_id, :tong_id
    end
    
    create_table :thangs do |t|
      t.integer :thing_id
      t.string  :name
    end
    
    create_table :thongs do |t|
      t.integer :thongable_id
      t.string  :thongable_type, :name
    end
    
    create_table :thung do |t|
      t.integer :thong_id
      t.string  :name
    end
    
    create_table :theongs do |t|
      t.integer :thing_id
      t.string  :name
    end
    
    create_table :theungs do |t|
      t.integer :theong_id, :thong_id
    end
  end
  
  class Thing < ActiveRecord::Base
    has_many  :thangs
    has_many  :tings
    has_many  :tongs, :through => :tings
    has_many  :thongs, :as => :thongable
    has_one   :theong
  end
  
  class Ting < ActiveRecord::Base
    belongs_to :thing
    belongs_to :tong
    has_and_belongs_to_many :tongs
  end
  
  class Tong < ActiveRecord::Base
    has_and_belongs_to_many :tings
  end
  
  class Thang < ActiveRecord::Base
    belongs_to :thing
  end
  
  class Thong < ActiveRecord::Base
    belongs_to :thongable, :polymorphic => true
    has_one    :thung
    has_one    :theung
    has_one    :theong, :through => :theung
  end
  
  class Thung < ActiveRecord::Base
    belongs_to :thong
  end
  
  class Theong < ActiveRecord::Base
    belongs_to :thing
  end
  
  class Theung < ActiveRecord::Base
    belongs_to :theong
    belongs_to :thong
  end
end