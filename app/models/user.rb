class User < ApplicationRecord
  has_and_belongs_to_many :interests
  has_and_belongs_to_many :skills

  enum :gender, [:male, :female], default: :male
end
