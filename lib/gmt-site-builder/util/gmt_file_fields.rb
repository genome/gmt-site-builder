module GMTFileFields
  def self.icon_fields
    [
      'icon_16',
      'icon_48',
    ]
  end

  def self.required_string_fields
    [
      'name',
      'biostars_tag',
      'short_name',
    ]
  end

  def self.menu_field
    'menu'
  end

  def self.additional_fields
    [
      'additional_downloads',
      'doc_downloads',
    ]
  end

  def self.resource_field
    'resources'
  end
end
