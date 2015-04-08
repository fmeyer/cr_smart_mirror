describe CRAN do
  describe "#configure" do

    before do
      CRAN.configure do |c|
        c.max_downloaded_packages = 100
      end
    end

    it 'Should load package max download' do
        expect(CRAN.config.max_downloaded_packages).to eq(100)
    end
  end
end