require 'fileutils'

class Wiki::RepoUpdateWorker
  include Sidekiq::Worker

  def perform(wiki_id)
    wiki = Wiki::Wiki.find(wiki_id)
    repo = wiki.repo

    @wikis = []
    Wiki::Wiki.where('repo = ?', repo).each do |a_wiki|
      @wikis << a_wiki
    end

    tmp_dir = File.join(Rails.root, 'tmp', 'wikis')
    repo_tmp_dir = File.join(tmp_dir, repo)

    FileUtils.rm_rf(repo_tmp_dir)
    FileUtils.mkpath(tmp_dir)
    Dir.chdir(tmp_dir) do
      `git clone --depth 1 https://github.com/#{repo}.git #{repo}`
    end

    @files = Dir["#{repo_tmp_dir}/**/*"]
    puts "files array #{@files}"

    @wikis.each do |a_wiki|
      start = File.join(repo_tmp_dir, 'projects')
      start_full = File.join(start, a_wiki.project.name)

      a_wiki.articles.each do |article|
        article.destroy
      end

      a_wiki.categories.each do |category|
        category.destroy
      end

      @files.each do |file|
        puts "a single file #{file}"
        if file.start_with?(start_full) && File.file?(file)
          full_file_path = file.dup
          file.sub!(start_full, '')

          wiki_attrs = a_wiki.repo.split('/')
          base_file = file.reverse.split('/')[0].reverse
          folders = file.sub(base_file, '').sub('/', '').split('/')

          if !folders[0].nil? && folders[0].match(/^(v|b).*/)
            category_folders = folders.drop(1)
          else
            category_folders = folders
          end

          file_params = {
            :wiki_id => wiki.id,
            :prefix => start,
            :repo_owner => wiki_attrs[0],
            :repo_name => wiki_attrs[1],
            :mod_name => a_wiki.project.name,
            :categories => category_folders,
            :file => base_file,
            :file_path => full_file_path
          }

          case folders[0]
          when /^v.*/
            file_params[:version] = folders[0][1..-1]
          when /^b.*/
            file_params[:build] = folders[0][1..-1]
          end
          puts "now we're sending params #{file_params}"
          article_update(file_params)
        end
      end
    end
  end

  def article_update(file_params)
    file_params.symbolize_keys!
    file_data = File.read(file_params[:file_path])
    wiki = Wiki::Wiki.find(file_params[:wiki_id])

    puts "just read in the data: #{file_data}"

    title = file_params[:file]
    title.scan(/(\.\w*)/).each do |match|
      title.sub!(match[0], '')
    end

    category ||= nil
    file_params[:categories].each do |folder|
      if category then cat_id = category.id else cat_id = nil end
      category = Wiki::Category.find_or_initialize_by(:parent_id => cat_id,
        :title => folder, :wiki_id => wiki.id)
      category.save
    end

    if category then cat_id = category.id else cat_id = nil end

    version_id = build_id = nil
    puts "before the v/b switch"
    if file_params[:version]
      version = wiki.project.versions.find_by_version(file_params[:version])
      version_id = version.id unless version.nil?
      return if version.nil?
    elsif file_params[:build]
      build = wiki.project.builds.find_by_build_number(file_params[:build])
      build_id = build.id unless build.nil?
      return if build.nil?
    end

    article = wiki.articles.find_or_initialize_by(:title => title,
                                                  :build_id => version_id,
                                                  :version_id => build_id,
                                                  :category_id => cat_id)

    article.update_attributes(:body => file_data.to_s)
    article.save
    puts "saved article"
  end
end
