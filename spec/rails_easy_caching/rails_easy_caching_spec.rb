require 'rails_helper'

class Dummy
  include RailsEasyCaching

  def dummies
    [1,2,3]
  end
  cached :dummies

  def super_dummies
    OpenStruct.new({
      :im => 'so dumb',
      :youre => 'not'
    })
  end
  cached :super_dummies, attrs: [:im]

  def id
    1
  end

  def reload
    self
  end

end

describe 'RailsEasyCaching' do
  before do
    Rails.cache = ActiveSupport::Cache::MemoryStore.new
  end

  describe '.config' do
    it 'configs RailsEasyCaching' do
      RailsEasyCaching.config do |config|
        config.test_exclude = false
      end

      expect(RailsEasyCaching.configuration.test_exclude).to eq false
    end
  end

  describe '.cached_*' do
    let(:dummy) { Dummy.new }

    before do
      RailsEasyCaching.config { |config| config.test_exclude = false }
    end

    it 'generates cached_* methods' do
      expect(dummy).to be_respond_to :cached_dummies
    end

    it 'generates clear_* methods' do
      expect(dummy).to be_respond_to :clear_cached_dummies
    end

    context 'cached_super_dummies (with attrs given)' do
      it 'returns only specific attrs' do
        expect(dummy.cached_super_dummies.to_h).to eq Hash.new({:im => 'so dumb'})
      end
    end

    context 'cached_dummies' do
      it 'returns the values of #dummies' do
        expect(dummy.cached_dummies).to eq [1,2,3]
      end

      it 'creates new cache key' do
        dummy.cached_dummies
        expect(Rails.cache.instance_variable_get('@data').keys).to be_include 'dummy_1_dummies'
      end
    end

    context 'clear_cached_dummies' do
      it 'clears cache key' do
        dummy.cached_dummies
        dummy.clear_cached_dummies
        expect(Rails.cache.instance_variable_get('@data').keys).not_to be_include 'dummy_1_dummies'
      end
    end
  end
end
