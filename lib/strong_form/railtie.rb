module StrongForm
  class Railtie < Rails::Railtie
    initializer 'strong_form.injects' do
      ActiveSupport.on_load(:active_record) do
        ActiveRecord::Base.include StrongForm::Record
      end

      ActiveSupport.on_load(:action_view) do
        %w(
          CheckBox
          CollectionSelect
          DateSelect
          RadioButton
          Select
          TextArea
          TextField
          TimeZoneSelect
        ).each do |klass|
          "ActionView::Helpers::Tags::#{klass}"
            .constantize.include StrongForm::Tag
        end

        if defined?(::NestedForm)
          require('strong_form/nested_form')
          require('nested_form/builder_mixin')
          ::NestedForm::BuilderMixin.include StrongForm::NestedForm
        end
      end

    end
  end
end
