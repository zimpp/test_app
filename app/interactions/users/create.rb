module Users
  class Create < ActiveInteraction::Base
    hash :params do
      string :email
      string :name
      string :patronymic
      string :nationality
      string :country
      string :gender
      integer :age
      string :surname, default: nil
      string :skills, default: ""
  
      array :interests, default: [] do
        string
      end
    end

    validate :validate_email_uniqueness
    validate :validate_age_inclusion
    validate :validate_gender_inclusion

    def execute
      User.create!(user_params)
    end

    private

    def validate_email_uniqueness
      errors.add("params.email", :not_unique) if User.exists?(email: params[:email])
    end

    def validate_age_inclusion
      errors.add("params.age", :is_too_short) if params[:age] <= 0
      errors.add("params.age", :is_too_long) if params[:age] > 90
    end

    def validate_gender_inclusion
      errors.add("params.gender", :not_inclusion) unless User.genders.keys.include?(params[:gender])
    end

    def user_params
      user_full_name = [params[:surname], params[:name], params[:patronymic]].join(' ')
    
      params.merge(
        user_full_name: user_full_name,
        skills: skills_params,
        interests: interests_params
      )
    end

    def skills_params
      skills_names = params[:skills].split(',')

      Skill.where(name: skills_names)
    end

    def interests_params
      Interest.where(name: params[:interests])
    end
  end
end
