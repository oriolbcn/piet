require 'rails'

module Piet
  class Railtie < ::Rails::Railtie
    initializer 'Rails logger' do
      Piet.logger = Rails.logger
    end
  end
end