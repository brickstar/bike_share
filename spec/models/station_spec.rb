require 'rails_helper'

describe Station, type: :model do
  describe "validations" do
    it { should validate_presence_of(:name) }
    it { should validate_presence_of(:dock_count) }
    it { should validate_presence_of(:city) }
    it { should validate_presence_of(:installation_date) }
  end

  describe "class methods" do
    it 'calculate total count of all stations'
    end

    it 'calculate average bikes per station'
    end

    it 'calculate most bikes available'
    end

    it 'calculate fewest bikes available'
    end

    it 'find station with most bikes available'
    end

    it 'find station with least bikes available'
    end

    it 'find oldest station'
    end

    it 'find newest station'
    end
  end
end
