class CreateEpisodes < ActiveRecord::Migration[7.2]
  def change
    create_table :episodes do |t|
      t.string :title, null: false
      t.datetime :published_at, null: false
      t.string :description
      t.boolean :explicit, default: true
      t.integer :duration

      t.timestamps
    end
  end
end
