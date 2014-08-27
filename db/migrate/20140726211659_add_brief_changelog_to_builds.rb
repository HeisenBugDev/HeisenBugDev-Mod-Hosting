class AddBriefChangelogToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :brief_changelog, :text
  end
end
