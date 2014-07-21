module WritableWithTemplate
  def save!(jekyll_site)
    destination_directory = jekyll_site.send(*destination)
    FileUtils.mkdir_p(destination_directory)
    destination_file = File.join(destination_directory, file_name)
    template_file = template
    evaluate_and_write_template(destination_file, template_file)
  end

  private
  def template
    File.join(GMTSiteBuilder.config.template_directory, template_name + '.erb')
  end

  def evaluate_and_write_template(destination_file, template_file)
    template = ERB.new(File.read(template_file))
    File.open(destination_file, 'w') do |f|
      f.write(template.result(binding))
    end
  end
end
