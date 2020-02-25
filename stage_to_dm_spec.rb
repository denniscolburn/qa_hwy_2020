describe 'stage to data mart' do
  context 'aggregate' do
    it 'by genre' do
      genre = "Fantasy"
      5.times do
        insert_row_into_stage(genre)
      end
      genre = "Science Fiction"
      3.times do
        insert_row_into_stage(genre)
      end

      run_workflow(@env, 'wf_aggregate_genres')

      rows = query_dm_table(@env)
      row1 = rows[0]
      row2 = rows[1]

      expect(row1[0]).to eq("Fantasy")
      expect(row1[1]).to eq(5)

      expect(row2[0]).to eq("Science Fiction")
      expect(row2[1]).to eq(3)
    end
  end
end
