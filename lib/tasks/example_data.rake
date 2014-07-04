require 'json'
require_relative 'example_data_messages'
include ExampleDataMessages

namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    open_generated_help
    write_to_help_file(@@start_message)
    reset_database
    Rake::Task["db:reset"].invoke
    download_assets
    make_users
    make_projects
    # make_builds
    # make_articles
    close_file
  end
end

@max_padding = 9
@generated_help_file_name = 'example_data_info.md'
@generated_help_file = nil

#
# Prints thor like lines
# @param string [String] The string you want to print
# @param label [String] Label for command (run, exists, etc)
# @param color [String] color for label
#
# @return [nil]
def print_command(string, label, color, prefix=nil, print_method=:puts)
  padding = @max_padding - label.length
  Object.send(print_method, "#{prefix}#{' ' * padding}#{label.send(color)}  "\
    " #{string}")
end

def run(command)
  print_command(command, 'run', :blue)
  puts `#{command}`
end

def create_print(string)
  print_command(string, 'create', :green)
end

def download_print(string)
  print_command(string, 'download', :green)
end

def exists_print(string)
  print_command(string, 'exists', :yellow)
end

def status_print(string)
  print_command(string, 'status', :white)
end

def warning_print(string)
  print_command(string, 'warning', :red)
end

def progress_print(current, max)
  print_command("#{current}/#{max}", 'progress', :to_s, "\r", :print)
  puts '' if current == max
end

def open_generated_help
  @generated_help_file = File.open(File.join(Rails.root,
    @generated_help_file_name), "w+")
end

def write_to_help_file(string)
  @generated_help_file.write("#{string}\n\n")
end

def record_to_json(record)
  JSON.pretty_generate(JSON.parse(record.to_json))
end

def write_record_markdown(record)
  json = record_to_json(record)
  write_to_help_file("## \#to_json output for #{record.class.name}\n")
  write_code_block(json)
end

def write_code_block(string)
  write_to_help_file("    #{string.gsub("\n", "\n    ")}\n")
end

def write_header_to_help_file(string)
  write_to_help_file("#{string}\n#{'=' * string.length}")
end

def reset_database
  warning_print("Resetting database in 3 seconds")
  sleep(3)
  warning_print("Resetting database")
  write_to_help_file(@@reset_database_message)
end

def close_file
  @generated_help_file.close
end

def download_assets
  download_print("Assets -> tmp/example_data_assets\n")

  Dir.chdir(File.join(Rails.root, 'tmp')) do
    if File.directory? 'example_data_assets'
      Dir.chdir('example_data_assets') do
        exists_print "tmp/example_data_assets/"
        run("git pull")
      end
    else
      url = "https://github.com/HeisenBugDev/HBD-Example-Data-Assets.git"
      run("git clone #{url} example_data_assets")
    end
  end
end

def make_users
  create_print "admin/owner user"
  admin = User.create!(name: "admin",
                       email: "admin@example.com",
                       password: "adminpassword",
                       password_confirmation: "adminpassword")
  admin.add_role("admin")
  admin.add_role("owner")

  status_print "Admin user created"
  write_header_to_help_file('Admin User')
  write_to_help_file(@@admin_user_message)
  write_record_markdown(admin)

  create_print "Normal users \n"

  last_user = nil

  99.times do |n|
    progress_print n + 1, 99
    name  = "#{Faker::Name.first_name}#{n}"
    email = "example-#{n+1}@example.com"
    password  = "foobarbaz"
    last_user = User.create!(name:     name,
                             email:    email,
                             password: password,
                             password_confirmation: password)
  end

  write_header_to_help_file('Normal Users')
  write_to_help_file(@@normal_user_message)
  write_record_markdown(last_user)

  status_print "Users created"
end

def make_projects
  write_header_to_help_file('Projects')
  create_print "Projects"
  code_repo = "HeisenBugDev/ExampleRepo"
  subtitle = "Yet another awesome mod"

  project = nil
  99.times do |n|
    progress_print n + 1, 99
    name = nil
    loop do
      name = Faker::Commerce.product_name
      break if Project.find_by_name(name).nil?
    end

    description = @@example_description.gsub('{{name}}', name)
    icon = Rack::Multipart::UploadedFile.new(File.join(Rails.root, 'tmp',
      'example_data_assets', 'projects', 'icons', "#{n}.png"))

    project = Project.create!(name: name,
                              code_repo: code_repo,
                              description: description,
                              subtitle: subtitle,
                              icon: icon)
  end

  write_to_help_file(@@projects_message)
  write_record_markdown(project)
  status_print "Projects created!"
end
