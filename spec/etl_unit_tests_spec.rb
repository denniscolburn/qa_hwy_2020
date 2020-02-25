
describe 'Flat file to raw' do
  before(:each) do
    @env = ENV["env"]
  end

  it 'does not transform the data' do
    isbn = rand(1000000000000..9999999999999)
    title = ["Book 1", "Book 2", "Book 3", "Book 4", "Book 5"].sample
    author = ["Author 1", "Author 2", "Author 3", "Author 4", "Author 5"].sample
    format = ["audiobook", "ebook"].sample
    length = format.eql?("audiobook") ? rand(100..200) : 0
    pages = format.eql?("ebook") ? rand(100..200) : 0
    genre = ["Fantasy", "Science Fiction", "History", "Romance", "Science"].sample
    line = isbn.to_s + "," + title + "," + author + "," + format + "," + length.to_s + "," + pages.to_s + "," + genre
    File.open('sample_file.dat', 'w') { |file| file.write(line) }

    upload_file(@env, 'sample_file.dat', '/remote/path/')
    run_workflow(@env, 'wf_load_file_to_raw')
    values_from_table = query_raw_table(@env)
    values = values_from_table.split(',')

    expect(isbn.to_s).to eq(values[0])
    expect(title).to eq(values[1])
    expect(author).to eq(values[2])
    expect(format).to eq(values[3])
    expect(length.to_s).to eq(values[4])
    expect(pages.to_s).to eq(values[5])
    expect(genre).to eq(values[6])
  end
end
