require 'rails_helper'

def all_user_attributes
  %i(first_name last_name gender description)
end

def all_addresses_attributes
  %i(street city country description)
end

def all_tags_attributes
  %i(name description)
end

RSpec.describe 'strong form' do
  describe 'basic form' do
    subject { visit '/basic_form' }

    context 'without permitted attributes' do
      before(:each) { subject }

      all_user_attributes.each do |attr|
        it "should enable #{attr}" do
          expect(page.find('[name="user[' + attr.to_s + ']"]')[:disabled])
            .to be_falsy
        end
      end
    end

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

  describe 'nested form' do
    subject { visit '/fields_for' }

    context 'without permitted attributes' do
      before(:each) { subject }

      describe 'has_many association' do
        all_addresses_attributes.each do |attr|
          it "should enable address #{attr}" do
            expect(page.find(
              '[name="user[addresses_attributes][0][' + attr.to_s + ']"]'
            )[:disabled])
              .to be_falsy
          end
        end

        all_tags_attributes.each do |attr|
          it "should enable tag #{attr}" do
            expect(page.find('[name="user[tag_attributes][' + attr.to_s + ']"]')[:disabled])
              .to be_falsy
          end
        end
      end
    end

    context 'with permitted attributes for addresses' do
      before(:each) do
        new_user = User.new
        allow(User).to receive(:new) do
          new_user.permitted_attributes = [
            :last_name, addresses_attributes: [:city]
          ]
          new_user
        end
        subject
      end

      describe 'has_many association' do
        (all_addresses_attributes - %i(city)).each do |attr|
          it "should disable address #{attr}" do
            expect(page.find(
              '[name="user[addresses_attributes][0][' + attr.to_s + ']"]'
            )[:disabled])
              .to be_truthy
          end
        end

        it 'should enable address city' do
          expect(page.find(
            '[name="user[addresses_attributes][0][city]"]'
          )[:disabled])
            .to be_falsy
        end
      end

      describe 'has_one association' do
        all_tags_attributes.each do |attr|
          it "should disable tag #{attr}" do
            expect(page.find('[name="user[tag_attributes][' + attr.to_s + ']"]')[:disabled])
              .to be_truthy
          end
        end
      end
    end

    context 'with permitted attributes for tag' do
      before(:each) do
        new_user = User.new
        allow(User).to receive(:new) do
          new_user.permitted_attributes = [
            :last_name, tag_attributes: [:name]
          ]
          new_user
        end
        subject
      end

      describe 'has_many association' do
        all_addresses_attributes.each do |attr|
          it "should disable address #{attr}" do
            expect(page.find(
              '[name="user[addresses_attributes][0][' + attr.to_s + ']"]'
            )[:disabled])
              .to be_truthy
          end
        end
      end

      describe 'has_one association' do
        (all_tags_attributes - %i(name)).each do |attr|
          it "should disable tag #{attr}" do
            expect(page.find('[name="user[tag_attributes][' + attr.to_s + ']"]')[:disabled])
              .to be_truthy
          end
        end

        it 'should enable tag name' do
          expect(page.find('[name="user[tag_attributes][name]"]')[:disabled])
            .to be_falsy
        end
      end
    end
  end

  describe 'deeply nested form' do
    subject { visit '/deep_fields_for' }

    context 'without permitted attributes' do
      before(:each) { subject }

      describe 'deeply nested has_many association' do
        all_tags_attributes.each do |attr|
          it "should enable address tag #{attr}" do
            expect(page.find(
              '[name="user[addresses_attributes][0][tags_attributes][0][' + attr.to_s + ']"]'
            )[:disabled])
              .to be_falsy
          end
        end
      end
    end

    context 'with permitted attributes deeply nested tag' do
      before(:each) do
        new_user = User.new
        allow(User).to receive(:new) do
          new_user.permitted_attributes = [
            addresses_attributes: { tags_attributes: [:name] }
          ]
          new_user
        end
        subject
      end

      describe 'deeply nested has_many association' do
        (all_tags_attributes - %i(name)).each do |attr|
          it "should disable address tag #{attr}" do
            expect(page.find(
              '[name="user[addresses_attributes][0][tags_attributes][0][' + attr.to_s + ']"]'
            )[:disabled])
              .to be_truthy
          end
        end

        it 'should enable address tag name' do
          expect(page.find(
            '[name="user[addresses_attributes][0][tags_attributes][0][name]"]'
          )[:disabled])
            .to be_falsy
        end
      end
    end
  end

  describe 'nested form gem' do
    subject { visit '/nested_form_gem' }

    it 'should work' do
      subject
    end

    context 'without permitted attributes' do
      before(:each) { subject }

      describe 'link to add' do
        it 'should be displayed' do
          expect(page)
            .to have_selector('[data-blueprint-id="addresses_fields_blueprint"]')
        end

        it 'blueprint should not have disabled fields' do
          expect(find('#addresses_fields_blueprint', visible: false)[:'data-blueprint'])
            .not_to include('disabled')
        end
      end
    end

    context 'with permitted attributes not including association' do
      before(:each) do
        new_user = User.new
        allow(User).to receive(:new) do
          new_user.permitted_attributes = []
          new_user
        end
        subject
      end

      describe 'link to add' do
        it 'should not be displayed' do
          expect(page)
            .not_to have_selector('[data-blueprint-id="addresses_fields_blueprint"]')
        end

        it 'should not add blueprint' do
          expect(page.all('#addresses_fields_blueprint', visible: false).length)
            .to eq(0)
        end
      end
    end

    context 'with permitted attributes including association' do
      before(:each) do
        new_user = User.new
        allow(User).to receive(:new) do
          new_user.permitted_attributes = [
            addresses_attributes: [:city]
          ]
          new_user
        end
        subject
      end

      describe 'link to add' do
        it 'should be displayed' do
          expect(page)
            .to have_selector('[data-blueprint-id="addresses_fields_blueprint"]')
        end

        it 'should add blueprint' do
          expect(page.all('#addresses_fields_blueprint', visible: false).length)
            .to eq(1)
        end

        (all_addresses_attributes - %i(city)).each do |attr|
          it "should disable address #{attr} in blueprint" do
            blueprint =
              page.find('#addresses_fields_blueprint', visible: false)[:'data-blueprint']
            tag = blueprint.match(/<[^>]+name=[^>]*#{attr}.*?>/)[0]

            expect(tag).to include('disabled')
          end
        end
        it 'should enable address city in blueprint' do
          blueprint =
            page.find('#addresses_fields_blueprint', visible: false)[:'data-blueprint']
          city_tag = blueprint.match(/<[^>]+name=[^>]*city.*?>/)[0]

          expect(city_tag).not_to include('disabled')
        end
      end
    end
  end
end
