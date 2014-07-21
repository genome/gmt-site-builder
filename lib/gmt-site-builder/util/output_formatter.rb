class ValidationResultFormatter
  def initialize(validation_result)
    @validation_result = validation_result
  end

  def to_s
    print_valid_repos if @validation_result.valid_repos.any?
    print_invalid_repos if @validation_result.invalid_repos.any?
  end

  private
  def print_valid_repos
    puts 'Valid GMT Repositories:'
    puts @validation_result.valid_repos
      .map { |r| "\t#{r.name}" }
      .join("\n")
    puts "\n"
  end

  def print_invalid_repos
    puts 'Invalid GMT Repositories:'
    puts @validation_result.invalid_repos
      .map { |r| "\t#{r.name}\n#{repo_errors(r)}" }
      .join("\n")
    puts "\n"
  end

  def repo_errors(repo)
    repo.errors.map { |e| "\t\t#{e}" }.join("\n")
  end
end
