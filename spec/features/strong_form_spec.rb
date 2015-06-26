require 'rails_helper'

def all_user_attributes
  %i(first_name last_name gender description)
end

RSpec.describe 'strong form' do
  describe 'basic form' do
    subject { visit '/basic_form' }

    context 'with permitted attributes' do
      before(:each) do
        new_user = User.new
        allow(User).to receive(:new) do
          new_user.permitted_attributes = [:last_name]
          new_user
        end
        subject
      end

      (all_user_attributes - %i(last_name)).each do |attr|
        it "should disable #{attr}" do
          expect(page.find('[name="user[' + attr.to_s + ']"]')[:disabled])
            .to be_truthy
        end
      end

      it 'should enable last_name' do
        expect(page.find('[name="user[last_name]"]')[:disabled])
          .to be_falsy
      end
    end
  end
end
