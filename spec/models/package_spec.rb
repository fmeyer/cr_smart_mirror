require 'spec_helper'

describe Package do

    before do
        @package_abc = Package.create!(name: "abctools", version: "1.0")
        @description_abc = Dcf.parse(Fixture.load("ABCTOOLS")).first
    end

    describe "#class" do
        it 'Should retrieve CRAN metadata' do
            expect(Package).to receive(:retrieve_package_list).and_return([{"Package" => "P", "Version" => "0.1"}])

            packages = Package.fetch_cran_packages

            expect(packages.last.name).to eq("P")
            expect(packages.last.version).to eq("0.1")
            expect(packages.last.status).to eq("created")
        end 

        it "Should retrieve named package with versions" do
            expect(Package).to receive(:all).and_return(Package)
            expect(Package).to receive(:group_by)            
            Package.all_with_versions
        end


    end

    describe '#instance ' do

        it 'should update Package contents' do
            expect(Package).to receive(:retrieve_package_metadata).with("abctools", "1.0").and_return(@description_abc)
            @package_abc.fetch_cran_package_metadata!


            expect(@package_abc.title).to eq("Tools for ABC analyses")
        end

        describe "named scopes" do
            before do
                @p = Package.new(name: "pkg", version: "1.0", maintainer: Maintainer.new(name: "jao"), authors: [Author.new(name: "jon")])
            end
            it "Should retrieve maintainer name" do
                expect(@p.maintainer_name).to eq("jao")
            end

            it "Should retrieve Authors name" do
                expect(@p.authors_names).to eq("jon")                
            end          
        end
    end
end

