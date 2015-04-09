feature 'WEB: List available packages' do
    before(:each) do
        Package.delete_all

        Package.create!(name: "abctools", version: "1.0")
        Package.create!(name: "abctools", version: "1.0.1")        

    end

    scenario 'Index should list all avaliable packages and versions' do
        visit '/'
        expect(page).to have_text('abctools 1.0')
        expect(page).to have_text('abctools 1.0.1')        
    end
end
