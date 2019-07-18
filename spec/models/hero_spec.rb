require 'rails_helper'

# Test suite for the Hero model
RSpec.describe Hero, type: :model do
  # Association test
  # ensure Hero model has a 1:m relationship with the Mission model
  it { should have_many(:missions).dependent(:destroy) }
  # Validation tests
  # ensure columns name, superpower, company and alignment are present before saving
  it { should validate_presence_of(:name) }
  it { should validate_presence_of(:superpower) }
  it { should validate_presence_of(:company) }
  it { should validate_presence_of(:alignment) }
end
