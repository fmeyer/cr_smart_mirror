require 'spec_helper'

describe Package do

    before do
        @package_abc = Package.create!(name: "abctools", version: "1.0")
        @description_abc = Dcf.parse(Fixture.load("ABCTOOLS")).first
    end

    it 'Should retrieve CRAN metadata' do
        expect(Package).to receive(:retrieve_package_list).and_return([{"Package" => "P", "Version" => "0.1"}])

        packages = Package.fetch_cran_packages

        expect(packages.last.name).to eq("P")
        expect(packages.last.version).to eq("0.1")
        expect(packages.last.status).to eq("created")
    end   


    describe '#instance ' do

        it 'should update Package contents' do

            expect(Package).to receive(:retrieve_package_metadata).with("abctools", "1.0").and_return(@description_abc)
            
            puts @package_abc
            @package_abc.fetch_cran_package_metadata!
            puts @package_abc

            expect(@package_abc.title).to eq("Tools for ABC analyses")
        end
    end
end

