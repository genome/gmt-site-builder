class ToolExporter
  def initialize(tool_repo, jekyll_site)
    @tool_repo = tool_repo
    @jekyll_site = jekyll_site
  end

  def export!
    validate
    write_config_file
    write_icons
    write_menu
    write_release_posts
  end

  private
  def validate
    raise "Jekyll site not valid!" unless @jekyll_site.valid?
    raise "#{@tool_repo.short_name} is not configured as a GMT!" unless @tool_repo.is_gmt?
  end

  def write_config_file
    @tool_repo.save!(@jekyll_site)
  end

  def write_icons
    GMTFileFields.icon_fields.each do |icon_accessor|
      icon = @tool_repo.config.send(icon_accessor)
      icon.save!(@jekyll_site)
    end
  end

  def write_menu
    @tool_repo.config.menu.each do |menu_item|
      menu_item.save!(@jekyll_site)
    end
  end

  def write_release_posts
    @tool_repo.releases.each do |release|
      release.save!(@jekyll_site)
    end
  end
end
