require 'rails_helper'

RSpec.describe Repository, type: :model do
  describe 'validations' do
    it { is_expected.to validate_presence_of :name }
    it { is_expected.to validate_uniqueness_of(:name).scoped_to(:parent_id) }
  end

  describe '#children' do
    let(:main_repository) { create(:repository) }
    let(:sub_repositories) do
      2.times.map { |i| create(:repository, name: "Repository #{i}", parent: main_repository) }
    end

    it 'return sub repositories' do
      expect(main_repository.children).to match_array(sub_repositories)
    end
  end

  describe '#parent' do
    let(:main_repository) { create(:repository) }
    let(:sub_repository) { create(:repository, parent: main_repository) }

    it 'return main repository' do
      expect(sub_repository.parent).to eq(main_repository)
    end
  end

  describe 'has_many_attached files' do
    let(:repository) { create(:repository) }

    before do
      repository.files.attach(io: File.open(Rails.root.join('spec', 'factories', 'images', 'batman.jpg')),
                           filename: 'batman.jpg',
                           content_type: 'image/jpg')
    end

    it { expect(repository.files).to be_an_instance_of(ActiveStorage::Attached::Many) }
  end

  describe 'scopes' do
    describe '.main' do
      let(:main_repositories) do
        2.times.map { |i| create(:repository, name: "Repository #{i}") }
      end

      let(:sub_repositories) do
        2.times.map { |i| create(:repository, name: "Repository #{i}", parent: main_repository) }
      end

      it 'returns only main repositories' do
        expect(described_class.main).to match_array(main_repositories)
      end
    end
  end
end
