module BuildsHelper
  def file_size(artifact)
    number_to_human_size(artifact.file.size)
  end
end
