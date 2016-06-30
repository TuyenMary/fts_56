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

  def start_time exam
    if exam.start? or exam.time_end.nil?
      content_tag :p, "00:00:00"
    else
      spent_time exam
    end
  end

  def spent_time exam
    if exam.time_end - exam.time_start < exam.duration * Settings.MINUTE
      time = exam.time_end - exam.time_start
    else
      time = exam.duration * Settings.MINUTE
    end
    Time.at(time).utc.strftime I18n.t("exams.format_time")
  end
end
