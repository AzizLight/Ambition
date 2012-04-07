class SlugValidator < ActiveModel::EachValidator
  def validate_each(record, attribute, value)
    slug = Post.find_by_slug(value) || Page.find_by_slug(value)
    if !slug.nil?
      record.errors[attribute] << (options[:message] || "is already taken")
    elsif !(value =~ /^(?:[a-z0-9]+-?)+[a-z0-9]$/i)
      record.errors[attribute] << (options[:message] || "is not a valid")
    end
  end
end
