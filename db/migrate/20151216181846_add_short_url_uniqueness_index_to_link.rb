class AddShortUrlUniquenessIndexToLink < ActiveRecord::Migration
  def change
    add_index :links, :short_url, unique: true
  end
end
