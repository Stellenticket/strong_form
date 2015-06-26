require 'rails_helper'

RSpec.describe User do
  describe '#permitted_nested_attributes?' do
    context 'without permitted attributes' do
      let(:user) { User.new }

      it 'should return true' do
        expect(user.permitted_nested_attributes?(:something))
          .to be(true)
      end
    end

    context 'with permitted attributes' do
      let(:user) do
        u = User.new
        u.permitted_attributes = [
          :first_name,
          { addresses_attributes: [:description] },
          tag_attributes: [:name]
        ]
        u
      end

      it 'should return true for has_many association' do
        expect(user.permitted_nested_attributes?(:addresses))
          .to be(true)
      end

      it 'should return true for has_one association' do
        expect(user.permitted_nested_attributes?(:tag))
          .to be(true)
      end

      it 'should return false if not permitted' do
        expect(user.permitted_nested_attributes?(:something))
          .to be(false)
      end

      it 'should return false if permission is attribute' do
        expect(user.permitted_nested_attributes?(:first_name))
          .to be(false)
      end
    end
  end
end
