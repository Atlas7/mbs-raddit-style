class AddCachedVotesToEntries < ActiveRecord::Migration
  def self.up
    add_column :entries, :cached_votes_total, :integer, :default => 0
    add_column :entries, :cached_votes_score, :integer, :default => 0
    add_column :entries, :cached_votes_up, :integer, :default => 0
    add_column :entries, :cached_votes_down, :integer, :default => 0
    add_index  :entries, :cached_votes_total
    add_index  :entries, :cached_votes_score
    add_index  :entries, :cached_votes_up
    add_index  :entries, :cached_votes_down

    # Uncomment this line to force caching of existing votes
    # Post.find_each(&:update_cached_votes)
  end

  def self.down
    remove_column :entries, :cached_votes_total
    remove_column :entries, :cached_votes_score
    remove_column :entries, :cached_votes_up
    remove_column :entries, :cached_votes_down
  end
end