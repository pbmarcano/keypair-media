class RemoveDurationFromEpisodes < ActiveRecord::Migration[7.2]
  def change
    remove_column :episodes, :duration, :integer
  end
end
