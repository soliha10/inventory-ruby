module ItemsHelper
INPUTS ={"string" => :text_field, "text" => :text_area, "number" => :number_field,
"link" => :url_field, "boolean" => :check_box }.freeze
def field_input(form, field) = form.public_send(INPUTS.fetch(field.kind), field.column, **input_options(field))
def field_value(item, field) = field.kind == "boolean" ? check_mark(item[field.column]) : item[field.column]
  private
  def input_options(field) = field.kind == "boolean" ? {class: "form-check-input"} : {class: "form-control", step: "any"}
def check_mark(value) = value ? "✓" : ""
end