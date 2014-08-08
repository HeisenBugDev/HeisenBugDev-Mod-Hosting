class ConvertDownloadsToInts < ActiveRecord::Migration
  def change
    if ActiveRecord::Base.connection.adapter_name == 'PostgreSQL'
      execute 'ALTER TABLE projects ALTER downloads TYPE integer USING downloads::int'
      execute 'ALTER TABLE builds ALTER downloads TYPE integer USING downloads::int'
    else
      change_column :projects, :downloads, :integer
      change_column :builds, :downloads, :integer
    end
  end
end
