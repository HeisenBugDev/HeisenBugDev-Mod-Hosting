class AddBuildTypesToBuilds < ActiveRecord::Migration
  def change
    add_column :builds, :build_state, :string
  end
end
