require 'rails_helper'

RSpec.describe User, type: :model do
  let(:user) { create(:user) }

  it "is invalid without a name" do
    user.name = nil
    user.valid?
    expect(user.errors[:name]).to include("can't be blank")
  end
end
