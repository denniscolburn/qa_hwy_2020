describe 'raw table to stage table' do
  context 'cleanse raw data' do
    it 'populates length based on format' do
      ebook_isbn = rand(1000000000000..9999999999999)
      ebook_pages = 500
      insert_raw_ebook_record(@env, ebook_isbn, ebook_pages, 0)
      audiobook_isbn = rand(1000000000000..9999999999999)
      audiobook_length = 1000
      insert_raw_audiobook_record(@env, audiobook_isbn, 0, audiobook_length)

      run_workflow(@env, 'wf_load_raw_to_stage')

      num_pages_1 = get_stage_length(@env, ebook_isbn, "ebook")
      expect(num_pages_1).to eq(ebook_pages)
      num_pages_2 = get_stage_length(@env, audiobook_isbn, "audiobook")
      expect(num_pages_2).to eq(audiobook_length)
    end
  end
end
