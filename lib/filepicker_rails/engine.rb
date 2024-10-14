require './lib/filepicker_rails/tag'

module FilepickerRails
  # @private
  class Engine < ::Rails::Engine
    config.filepicker_rails = FilepickerRails::Configuration.new
    isolate_namespace FilepickerRails

    initializer 'filepicker_rails.form_builder' do
      Rails.application.reloader.to_prepare do
        require_relative '../../app/helpers/filepicker_rails/form_helper'
        ActionView::Helpers::FormBuilder.send(:include, FilepickerRails::FormHelper)
      end
    end

    initializer 'filepicker_rails.action_controller' do |app|
      ActiveSupport.on_load(:action_controller) do
        require_relative '../../app/helpers/filepicker_rails/application_helper'
        helper FilepickerRails::ApplicationHelper
      end
    end
  end
end
