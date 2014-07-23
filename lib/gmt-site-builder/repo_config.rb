class RepoConfig
  attr_reader :errors
  attr_reader :menu
  attr_reader :resources

  GMTFileFields.required_string_fields.each do |field|
    attr_accessor field.to_sym
  end

  GMTFileFields.icon_fields.each do |field|
    attr_accessor field.to_sym
  end

  GMTFileFields.additional_fields.each do |field|
    attr_accessor field.to_sym
  end

  def initialize(repo, raw_repo_config)
    @repo = repo
    @errors = []
    @menu = []
    @resources = []
    config_data = YAML.load(raw_repo_config)
    process_config(config_data)
  end

  def valid?
    @errors.none?
  end

  private
  def process_config(config)
    process_string_fields(config)
    process_icon_fields(config)
    process_menu(config)
    process_resources(config)
    process_additional_fields(config)
    if config.any?
      @errors << "Extra keys specified: #{config.keys.join(',')}"
    end
  end

  def process_string_fields(config)
    GMTFileFields.required_string_fields.each do |field|
      value = config.delete(field)
      if value
        self.send("#{field}=", value)
      else
        @errors << "No value given for required field: #{field}"
      end
    end
  end

  def process_icon_fields(config)
    GMTFileFields.icon_fields.each do |field|
      value = config.delete(field)
      begin
        if value
          self.send("#{field}=", Icon.new(@repo, value, short_name))
        else
          @errors << "No value given for required field: #{field}"
        end
      rescue Octokit::NotFound
        @errors << "File not found at #{value}"
      end
    end
  end

  def process_menu(config)
    menu = config.delete(GMTFileFields.menu_field)
    if menu && menu.any?
      if menu.any? { |menu_item| menu_item['href'] =~ /index/i }
        menu.each do |menu_item|
          begin
            @menu << MenuPage.new(menu_item['text'], menu_item['href'], @repo, short_name)
          rescue Octokit::NotFound
            @errors << "File not found at #{menu_item['href']}"
          end
        end
      else
        @errors << 'Menu must contain an index.html/md file!'
      end
    else
      @errors << 'No value given for required field "menu"'
    end
  end

  def process_resources(config)
    config_resources = config.delete(GMTFileFields.resource_field) || []
    config_resources.each do |resource|
      begin
        @resources << Resource.new(@repo, resource, short_name)
      rescue Octokit::NotFound
        @errors << "Resource not found at #{value}"
      end
    end
  end

  def process_additional_fields(config)
    GMTFileFields.additional_fields.each do |field|
      if config.has_key?(field)
        self.send("#{field}=", config.delete(field))
      end
    end
  end
end
