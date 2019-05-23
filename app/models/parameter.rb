# == Schema Information
#
# Table name: parameters
#
#  id         :integer          not null, primary key
#  key        :string(255)
#  value      :string(255)
#  created_at :datetime         not null
#  updated_at :datetime         not null
#

class Parameter < ActiveRecord::Base
  
  def self.[](key)
    p = Parameter.where(key: key).first 
    p ? p.value : nil
  end

  def self.[]=(key, value)
    p = Parameter.where(key: key).first || Parameter.new(key: key)
    p.value = value
    p.save
  end
  
end
