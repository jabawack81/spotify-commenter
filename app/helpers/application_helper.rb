# frozen_string_literal: true

# Application Helper module
module ApplicationHelper
  def flash_class(key)
    case key
    when "notice"
      "alert-success"
    when "alert"
      "alert-warning"
    else
      "alert-#{key}"
      # "alert-info"
      # "alert-warning"
      # "alert-danger"
    end
  end
end
