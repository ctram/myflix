require 'spec_helper'

feature 'Signing in' do
  let(:alice) {Fabricate(:user)}

  scenario 'Signing in with correct credentials' do
    sign_in(alice)
    expect(page).to have_content 'successfully'
  end

end
