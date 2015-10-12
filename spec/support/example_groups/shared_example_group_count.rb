class Symbol
  def to_count
    (to_s.pluralize + "_count").to_sym
  end
  def to_plural
    to_s.pluralize.to_sym
  end
end

shared_examples "with no has_many" do
  it { expect(base[target_sym.to_count]).to eq(0) }
end

shared_examples "with one has_many" do
  it { expect{create(target_sym, target_attributes) and base.reload}.to\
    change{base[target_sym.to_count]}.by(1) }
end

shared_examples "with one has_many deleted" do
  let!(:target) { create(target_sym, target_attributes) }
  it {
    base.reload
    expect{target.destroy and base.reload}.to\
    change{base[target_sym.to_count]}.by(-1) 
    }
end

shared_examples "with one has_many for another" do
  it { expect{create(target_sym, another_attributes)}.to change{
      base[target_sym.to_count]}.by(0) }
end
