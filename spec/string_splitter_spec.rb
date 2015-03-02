require "string_splitter"

describe StringSplitter do
  it 'finds all phrases' do
    expect(subject.split "Hello World Ruby", 6).to eq "'Hello', 'World', 'Ruby', 'Hello World', 'World Ruby', 'Hello World Ruby'"
  end

  it 'returns all phrases when asked for more than exist' do
    expect(subject.split "Hello World Ruby", 10).to eq "'Hello', 'World', 'Ruby', 'Hello World', 'World Ruby', 'Hello World Ruby'"
  end

  it 'returns the first n phrases when asked for fewer than exist' do
    expect(subject.split "Hello World Ruby", 4).to eq "'Hello', 'World', 'Ruby', 'Hello World'"
  end

  it 'returns the first word when asked for one phrase' do
    expect(subject.split "Hello World Ruby", 1).to eq "'Hello'"
  end

  it "works if there are fewer than three words" do
    expect(subject.split "Hello World", 3).to eq "'Hello', 'World', 'Hello World'"
  end

  it "supports phrases longer than three words" do
    expect(subject.split "Hello World From Ruby", 20).to eq "'Hello', 'World', 'From', 'Ruby', " +
      "'Hello World', 'World From', 'From Ruby', 'Hello World From', 'World From Ruby', 'Hello World From Ruby'"
  end
end
