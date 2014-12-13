class Configuration
  attr_accessor :test_exclude

  def initialize
    self.test_exclude = true
  end

  def test_exclude?
    test_exclude && Rails.env.test?
  end
end
