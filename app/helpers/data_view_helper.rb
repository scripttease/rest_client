module DataViewHelper

  def data_to_tags(data)
    case data
    when Array
      list_wrap(:ol, data.map { |elem| data_to_tags(elem) })
    when Hash
      list_wrap(:ul, data.map { |k, v| content_tag(:b, "#{k}: ") + data_to_tags(v) })
    when String
      data
    else
      data.to_s
    end
  end

  def list_wrap(tag_type, enum)
    list_items = enum.map do |elem|
      content_tag(:li, elem)
    end
    content_tag(tag_type, list_items.reduce(:+))
  end
end
