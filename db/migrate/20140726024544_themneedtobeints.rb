class Themneedtobeints < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute 'ALTER TABLE projects ALTER latest_release_build_id TYPE integer USING latest_release_build_id::int'
      execute 'ALTER TABLE projects ALTER latest_beta_build_id TYPE integer USING latest_beta_build_id::int'
      execute 'ALTER TABLE projects ALTER latest_normal_build_id TYPE integer USING latest_normal_build_id::int'
   else
     change_column :projects, :latest_release_build_id, :integer
     change_column :projects, :latest_beta_build_id, :integer
     change_column :projects, :latest_normal_build_id, :integer
   end
  end
end
