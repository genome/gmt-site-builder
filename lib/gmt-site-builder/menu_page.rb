class MenuPage
  include WritableWithTemplate

  attr_reader :content
  attr_reader :short_name
  attr_reader :file_name
  attr_reader :title

  def initialize(title, page_path, repo, package_name)
    @content = GithubApi.get_file_for_repo_and_path(repo, page_path)
    @title = title
    @repo = repo
    @file_name = File.basename(page_path)
    @short_name = package_name
  end

  private
  def template_name
    'tool_page'
  end

  def destination
    [:tool_directory, short_name]
  end
end
