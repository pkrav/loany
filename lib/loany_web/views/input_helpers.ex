defmodule LoanyWeb.InputHelpers do
  use Phoenix.HTML

  def input(form, field, field_label \\ nil) do
    type = Phoenix.HTML.Form.input_type(form, field)

    wrapper_opts = [class: "form-group #{state_class(form, field)}"]
    label_opts = [class: "control-label"]
    input_opts = [class: "form-control"]
    validations = Phoenix.HTML.Form.input_validations(form, field)
    input_opts = Keyword.merge(validations, input_opts)

    content_tag :div, wrapper_opts do
      label = label(form, field, humanize(field_label || field), label_opts)
      input = apply(Phoenix.HTML.Form, type, [form, field, input_opts])
      error = LoanyWeb.ErrorHelpers.error_tag(form, field)
      [label, input, error || ""]
    end
  end

  defp state_class(form, field) do
    cond do
      # The form was not yet submitted
      !form.source.action -> ""
      form.errors[field] -> "has-error"
      true -> "has-success"
    end
  end
end
