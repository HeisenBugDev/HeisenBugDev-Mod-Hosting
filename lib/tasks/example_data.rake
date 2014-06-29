namespace :db do
  desc "Fill database with sample data"
  task :populate => :environment do
    warning_print("Resetting database in 3 seconds")
    sleep(3)
    warning_print("Resetting database")
    Rake::Task["db:reset"].invoke
    download_assets
    make_users
    make_projects
    # make_builds
    # make_articles
  end
end

def run(command)
  puts "      #{"run".blue}   #{command}"
  puts `      #{command}`
end

def create_print(string)
  puts "   #{"create".green}   #{string}"
end

def download_print(string)
  puts " #{"download".green}   #{string}"
end

def exists_print(string)
  puts "   #{"exists".yellow}   #{string}"
end

def status_print(string)
  puts "   #{"status".white}   #{string}"
end

def warning_print(string)
  puts "  #{"warning".red}   #{string}"
end

def progress_print(current, max)
  print "\r #{"progress"}   #{current}/#{max}"
  puts '' if current == max
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
  admin = User.create!(name: "Joe",
                       email: "joe@example.com",
                       password: "foobarbaz",
                       password_confirmation: "foobarbaz")
  admin.add_role("admin")
  admin.add_role("owner")

  create_print "Normal users \n"

  99.times do |n|
    progress_print n + 1, 99
    name  = "#{Faker::Name.first_name}#{n}"
    email = "example-#{n+1}@example.com"
    password  = "foobarbaz"
    User.create!(name:     name,
                 email:    email,
                 password: password,
                 password_confirmation: password)
  end

  status_print "Users created"
end

def make_projects
  create_print "Projects"
  code_repo = "HeisenBugDev/ExampleRepo"
  subtitle = "Yet another awesome mod"

  99.times do |n|
    progress_print n + 1, 99
    name = nil
    loop do
      name = Faker::Commerce.product_name
      break if Project.find_by_name(name).nil?
    end

    description = @example_description.gsub('{{name}}', name)
    icon = Rack::Multipart::UploadedFile.new(File.join(Rails.root, 'tmp',
      'example_data_assets', 'projects', 'icons', "#{n}.png"))

    Project.create!(name: name,
                    code_repo: code_repo,
                    description: description,
                    subtitle: subtitle,
                    icon: icon)
  end

  status_print "Projects created!"
end


@example_description = <<-DESC.gsub('\n', ' ')
  Welcome to my amazing mod, {{name}}. This mod will save your life.
  I am not liable for any life saving not done. It is your fault because you
  clearly did not play this mod.
DESC