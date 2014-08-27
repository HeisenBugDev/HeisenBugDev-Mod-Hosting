module ExampleDataMessages
  def self.read_file(name)
    File.open(File.join(Rails.root, 'lib', 'tasks', 'example_messages',
                        "#{name}.md"), 'rb').read
  end

  @@start_message = read_file('start_message')
  @@reset_database_message = read_file('reset_database_message')
  @@example_description = read_file('example_description')
  @@admin_user_message = read_file('admin_user_message')
  @@normal_user_message = read_file('normal_user_message')
  @@projects_message = read_file('projects_message')
end
