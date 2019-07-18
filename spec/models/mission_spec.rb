require 'rails_helper'

# Test suite for the Mission model
RSpec.describe Mission, type: :model do
  # Association test
  # ensure an item record belongs to a single hero record
  it { should belong_to(:hero) }
  # Validation test
  # ensure column description, date, status and place is present before saving
  it { should validate_presence_of(:description) }
  it { should validate_presence_of(:date) }
  it { should validate_presence_of(:place) }
  it { should validate_presence_of(:status) }
end
