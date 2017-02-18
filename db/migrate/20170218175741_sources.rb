class Sources < ActiveRecord::Migration[5.0]
  def change
    create_table :sources do |table|
      table.string :source
      table.string :rss
      table.string :category
    end
  end
end
