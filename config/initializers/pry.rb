# frozen_string_literal: true

# config/initializers/pry.rb

old_prompt = Pry.config.prompt
env = case Rails.env
      when "production"   then Pry::Helpers::Text.red(Rails.env.upcase)
      when "staging"      then Pry::Helpers::Text.yellow(Rails.env.upcase)
      when "development"  then Pry::Helpers::Text.green(Rails.env.upcase)
      when "test"         then Pry::Helpers::Text.blue(Rails.env.upcase)
      else Pry::Helpers::Text.magenta("NO IDEA")
      end

Pry.config.prompt = [
  proc { |*a| "#{env} #{old_prompt.first.call(*a)}" },
  proc { |*a| "#{env} #{old_prompt.second.call(*a)}" }
]
