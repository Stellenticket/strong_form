module StrongForm
  def self.inject
    ActiveRecord::Base.include StrongForm::Record

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
        .constantize.prepend StrongForm::Tag
    end
  end

  class Railtie < Rails::Railtie
    initializer 'strong_form.injects' do
      if !Rails.env.test? && Rails.configuration.cache_classes
        StrongForm.inject
      else
        ActionDispatch::Reloader.to_prepare { StrongForm.inject }
      end
    end
  end
end
