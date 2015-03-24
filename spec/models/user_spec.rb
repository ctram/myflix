require_relative '../spec_helper'

describe User do
  it {should have_many :reviews}

  it {should validate_presence_of :name_first}
  it {should validate_presence_of :name_last}
  it {should validate_presence_of :email}
  it {should validate_uniqueness_of :email}
  it {should validate_presence_of :password}

end
