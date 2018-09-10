require 'rails_helper'

RSpec.describe Note, type: :model do

  # before do
  #   @user = FactoryBot.create(:user)
  #   @project = @user.projects.create(
  #     name: 'Test Project',
  #   )
  # end

  let(:user) { FactoryBot.create(:user) }
  let(:project) { FactoryBot.create(:project, owner: user) }

  it 'is valid with a user, project, and message' do
    note = Note.new(
      message: 'This is a sample note.',
      user: user,
      project: project,
    )
    expect(note).to be_valid
  end

  it 'is invalid without a message' do
    note = Note.new(message: nil)
    note.valid?
    expect(note.errors[:message]).to include('can\'t be blank')
  end

  describe 'search message for a term' do
    let!(:note1) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: 'This is the first note.',
      )
    }

    let!(:note2) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: 'This is the second note.',
      )
    }

    let!(:note3) {
      FactoryBot.create(:note,
        project: project,
        user: user,
        message: 'And this is the first note, too.',
      )
    }

    context 'when a match is found' do
      it 'returns notes that match the search term' do
        expect(Note.search('first')).to include(note1, note3)
        expect(Note.search('first')).to_not include(note2)
      end
    end

    context 'when no match is found' do
      it 'returns an empty collection' do
        expect(Note.search('message')).to be_empty
        expect(Note.count).to eq 3
      end
    end
  end

  it 'generates assocated data from a factory' do
    note = FactoryBot.create(:note)
    puts "This note's project is #{note.project.inspect}"
    puts "This note's user is #{note.user.inspect}"
  end

  describe 'mock and stubs' do
    it 'delegate to the user who created it without Mock & Stab' do
      user = FactoryBot.create(:user)
      note = Note.new(user: user)
      expect(note.user_name).to eq 'Pavlo Kasianchuk'
    end

    it 'delegate to the user who created it with Mock & Stab' do
      user = instance_double('User', name: 'Pavlo Kasianchuk')
      note = Note.new
      allow(note).to receive(:user).and_return(user)
      expect(note.user_name).to eq 'Pavlo Kasianchuk'
    end
  end
end
