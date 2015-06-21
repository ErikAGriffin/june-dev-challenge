require './lib/TreeParser'

describe TreeParser do

  it 'Can load a triangle data file into a nested array' do
    tree = TreeParser.send(:load_triangle,'data/triangle')
    file_length = File.open('data/triangle').count
    expect(tree.length).to eq file_length
    expect(tree.last.length).to eq file_length
  end

  it 'Finds the minimum path sum of a small triangle' do
    expect(TreeParser.parse_least_sum('data/tri')).to eq 168
  end

  # Note this test is merely to make sure my changes do
  # not affect output. I have no guarantee the value
  # given is the correct minimum sum.
  it 'Finds the minimum path sum of a large triangle' do
    expect(TreeParser.parse_least_sum('data/triangle')).to eq 2768
  end



end
