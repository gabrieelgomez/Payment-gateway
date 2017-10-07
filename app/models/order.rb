class Order < ActiveRecord::Base

  def self.token
    @axew = (('a'..'z').to_a + (0..9).to_a).shuffle.take(8).join
  end

end
