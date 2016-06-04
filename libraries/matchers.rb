if defined?(ChefSpec)
  ChefSpec.define_matcher(:telegraf_input)

  def create_telegraf_input(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:telegraf_input, :create, prospector)
  end

  def delete_telegraf_input(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:telegraf_input, :delete, prospector)
  end

  ChefSpec.define_matcher(:telegraf_output)

  def create_telegraf_input(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:telegraf_output, :create, prospector)
  end

  def delete_telegraf_input(prospector)
    ChefSpec::Matchers::ResourceMatcher.new(:telegraf_output, :delete, prospector)
  end
end
