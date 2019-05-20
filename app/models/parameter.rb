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
