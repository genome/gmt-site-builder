class Resource
  attr_reader :short_name
  attr_reader :file_name

  def initialize(repo, path, package_name)
    @resource_contents = GithubApi.get_file_for_repo_and_path(repo, path)
    @file_name = File.basename(path)
    @short_name = package_name
  end

  def save!(jekyll_site)
    destination_directory = jekyll_site.tool_directory(short_name)
    FileUtils.mkdir_p(destination_directory)
    destination_file = File.join(destination_directory, file_name)
    File.open(destination_file, write_mode) do |f|
      f.write(@resource_contents)
    end
  end

  private
  def write_mode
    #crummy hack for now
    if File.extname(file_name) =~ /\.(jpg|jpeg|png|pdf)$/i
      'wb'
    else
      'w'
    end
  end
end
