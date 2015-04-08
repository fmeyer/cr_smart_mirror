describe CRANrepo do
  describe "#configure" do

    before do
      CRANrepo.configure do |c|
        c.max_downloaded_packages = 100
      end
    end

    it 'Should load package max download' do
        expect(CRANrepo.config.max_downloaded_packages).to eq(100)
    end
  end
end