module ApplicationHelper
  def full_title page_title = ""
    base_title = I18n.t "title.framgia"
    page_title.empty? ? base_title : page_title + " | " + base_title
  end

  def link_to_remove_fields name, f
    f.hidden_field(:_destroy) + link_to(name, "#",
      onclick: "remove_fields(this)")
  end

  def link_to_add_fields name, f, association
    new_object = f.object.class.reflect_on_association(association).klass.new
    fields = [
      "<div class='form-group'>",
      f.fields_for(association, new_object, child_index:
        "new_#{association}") do |builder|
        render(association.to_s.singularize + "_form", f: builder)
      end,
      "</div>"
    ].join
    link_to name, "#", onclick: "return add_fields(this, \"#{association}\",
      \"#{escape_javascript(fields)}\")", class: "btn btn-info btn-block"
  end
end
