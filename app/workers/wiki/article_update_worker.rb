require 'fileutils'

class Wiki::ArticleUpdateWorker
  include Sidekiq::Worker

  def perform(file_params)
    file_params.symbolize_keys!
    file_data = File.read(file_params[:file_path])
    wiki = Wiki::Wiki.find(file_params[:wiki_id])

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
      :build_id => version_id, :version_id => build_id, :category_id => cat_id)
    article.update_attributes(:body => file_data.to_s)
    article.save
  end
end
