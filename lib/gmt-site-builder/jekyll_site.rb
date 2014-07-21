class JekyllSite
  attr_reader :data_directory

  def initialize(site_root = GMTSiteBuilder.config.jekyll_repo_directory,
                 data_directory = GMTSiteBuilder.config.jekyll_data_directory,
                 tool_directory = GMTSiteBuilder.config.jekyll_tool_directory,
                 image_directory = GMTSiteBuilder.config.jekyll_tool_image_directory,
                 posts_directory = GMTSiteBuilder.config.jekyll_posts_directory)

    @tool_directory = tool_directory
    @data_directory = File.join(site_root, data_directory)
    @image_directory = image_directory
    @site_root = site_root
    @posts_directory = posts_directory
  end

  def valid?
    File.directory?(@site_root)
  end

  def tool_directory(tool_name)
    File.join(@site_root, @tool_directory, tool_name)
  end

  def image_directory(tool_name)
    File.join(tool_directory(tool_name), @image_directory)
  end

  def releases_directory
    File.join(@site_root, @posts_directory)
  end
end
