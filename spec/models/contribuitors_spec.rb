require 'spec_helper'

describe "Contribuitors" do

    before do
      @maintainer = "FM <email@email.com>"
      @authors = "FM2 <email2@email.com>, FM3"
    end

    describe "#class" do
        it 'Should parse maintainer name and email' do
            m = Maintainer.parse(@maintainer).first
            expect(m.email).to eq("email@email.com")
            expect(m.name).to eq("FM")            
        end 

        it 'Should parse Authors names and emails' do
            a = Author.parse(@authors)

            expect(a.first.email).to eq("email2@email.com")
            expect(a.first.name).to eq("FM2")            

            expect(a.last.name).to eq("FM3")
            expect(a.last.email).to eq(nil)
        end 
 
    end
end

