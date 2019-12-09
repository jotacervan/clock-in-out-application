require 'rails_helper'

RSpec.describe Day, type: :model do
  context 'Create day' do
    it 'should be valid' do
      day = build(:day)
      expect(day.valid?).to be(true)
    end
    it 'should change day count by +1' do
      expect{
        day = create(:day)
      }.to change(Day,:count).by(+1)
    end
    it 'should not be valid without date_reg' do
      day = build(:day, :without_date_reg)
      expect(day.valid?).to be(false)
    end
    it 'should not be valid without month' do
      day = build(:day, :without_month)
      expect(day.valid?).to be(false)
    end
    it 'should not be valid without week' do
      day = build(:day, :without_week)
      expect(day.valid?).to be(false)
    end
    it 'should raise activerecord invalid' do
      expect{
        day = Day.create!()
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
  end
  context 'Update day' do
    before(:each) do
      @day = create(:day)
    end
    it 'should update seconds to 21600' do
      @day.update(seconds: 21600)
      @day.reload
      expect(@day.seconds).to be(21600)
    end
    it 'should not update date_reg to nil' do
      expect{
        @day.update!(date_reg: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'should not update user to nil' do
      expect{
        @day.update!(user_id: nil)
      }.to raise_error(ActiveRecord::RecordInvalid)
    end
    it 'should update odd to true' do
      @day.update(odd: true)
      @day.reload
      expect(@day.odd).to be(true)
    end
  end
  context 'Destroy day' do
    before(:each) do
      @day = create(:day)
    end
    it 'should change day count by -1' do
      expect{
        @day.destroy
      }.to change(Day,:count).by(-1)
    end
    it 'should destroy every time_reg when destroying a day' do
      @day.time_regs.create(time_reg: DateTime.now)
      id = @day.time_regs.first.id
      @day.destroy
      expect{
        TimeReg.find(id)
      }.to raise_error(ActiveRecord::RecordNotFound)
    end
  end
end
