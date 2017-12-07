describe 'tests' do
  it 'has a failing test' do
    expect(true).to be false
  end

  it 'has a passing test' do
    expect(true).to be true
  end

  it 'has a pending test' do
    pending
  end
end

