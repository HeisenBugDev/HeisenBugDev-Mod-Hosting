class MoveVersionNumberToVersionModel < ActiveRecord::Migration
  def change
    add_column :builds, :version_id, :integer

    Build.find_each do |build|
      version =
        Version.find_or_initialize_by_project_id_and_version(build.project_id,
          build.mod_version)
      version.builds << build
      version.save!
    end
  end
end
