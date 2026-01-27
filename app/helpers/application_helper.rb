module ApplicationHelper
  def input_class(resource, attrbute)
    classes = ["input"]
    classes << 'is-danger' if resource.errors[attrbute].any?
    classes.join(" ")
  end
end
