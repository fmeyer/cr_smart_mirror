describe CRAN::Repository do

    class Repo 
        include CRAN::Repository
    end

    before do
      @package_matadata = Fixture.load("PACKAGES")
      @package_binary_file = Fixture.load("abctools_1.0.tar.gz")
    end
    
    context "download" do
        it "Should build a correct package filename" do
            package_filename = Repo.class_eval { package_filename("package","0.0.1") } 
            expect(package_filename).to eq("package_0.0.1.tar.gz")
        end

        it "Should define the max download package number" do
            expect(Repo.max_packages).to eq(50)
        end

        it "Should retrieve the package_list" do
            expect(Repo).to receive(:get).with("http://mirr/PACKAGES").and_return(@package_matadata)

            packages = Repo.retrieve_package_list

            expect(packages.size).to eq(2)
            expect(packages.first['Package']).to eq('ACNE')
        end

        it "Should extract package metadata" do 
            expect(Repo).to receive(:get).with("http://mirr/abctools_1.0.tar.gz").and_return(@package_binary_file)

            package_metadata = Repo.retrieve_package_metadata("abctools", "1.0")
            expect(package_metadata["Title"]).to eq('Tools for ABC analyses')
        end
    end
end