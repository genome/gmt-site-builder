class Icon
  attr_reader :file_name
  def initialize(repo, path, package_name)
    @icon_data = GithubApi.get_file_for_repo_and_path(repo, path)
    @repo = repo
    @file_name = File.basename(path)
    @package_name = package_name
  end

  def save!(jekyll_site)
    destination_directory = jekyll_site.image_directory(@package_name)
    FileUtils.mkdir_p(destination_directory)
    destination_file = File.join(destination_directory, file_name)
    File.open(destination_file, 'wb') do |f|
      f.write(@icon_data)
    end
  end
end
