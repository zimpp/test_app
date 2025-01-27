require 'rails_helper'
require 'ffaker'

describe Users::Create do
  subject(:result) { described_class.run(params: params) }

  let(:interests) do
    3.times.map { |i| create(:interest) }
  end

  let(:skills) do
    3.times.map { |i| create(:skill) }
  end

  let(:params) do
    {
      email: FFaker::Internet.unique.email,
      name: FFaker::NameRU.first_name,
      surname: FFaker::NameRU.last_name,
      patronymic: FFaker::NameRU.first_name,
      nationality: FFaker::Address.country.downcase,
      country: FFaker::Address.country,
      gender: User.genders.keys.sample,
      age: rand(18...60),
      interests: interests.pluck(:name),
      skills: skills.pluck(:name).join(",")
    }
  end

  context "valid params" do
    let(:created_user) { User.first }

    it "creates and returns a new user" do
      expected_user_full_name = [params[:surname], params[:name], params[:patronymic]].join(' ')

      expect { result }.to change(User, :count).from(0).to(1)

      expect(created_user).to have_attributes(
        email: params[:email],
        name: params[:name],
        surname: params[:surname],
        patronymic: params[:patronymic],
        nationality: params[:nationality],
        country: params[:country],
        gender: params[:gender],
        age: params[:age],
        user_full_name: expected_user_full_name
      )

      expect(created_user.interests.count).to eq interests.size
      expect(created_user.interests.pluck(:id)).to eq interests.pluck(:id)

      expect(created_user.skills.count).to eq skills.size
      expect(created_user.skills.pluck(:id)).to eq skills.pluck(:id)
    end
  end
  
  describe "with invalid params" do
    context "when params is empty" do
      let(:params) { {} }

      it "return error" do
        error_messages = %w[email name patronymic nationality country gender age]
  
        error_messages.map!{|param| "Params #{param} is required"}
  
        expect do
          expect(result.errors.full_messages).to contain_exactly(*Array.wrap(error_messages))
        end.to_not change(User, :count)
      end
    end

    context "when age > 90" do
      let(:params) { super().merge(age: 91) }

      it "return error" do
        expect do
          expect(result.errors.full_messages).to contain_exactly("Params age can be less then 90")
        end.to_not change(User, :count)
      end
    end

    context "when age < 0" do
      let(:params) { super().merge(age: -1) }

      it "return error" do
        expect do
          expect(result.errors.full_messages).to contain_exactly("Params age can be more then 0")
        end.to_not change(User, :count)
      end
    end

    context "when email contains in database" do
      let!(:existing_user) { create(:user)}
      let(:params) { super().merge(email: existing_user.email) }

      it "return error" do
        expect do
          expect(result.errors.full_messages).to contain_exactly("Params email already exists")
        end.to_not change(User, :count)
      end
    end
  end
end