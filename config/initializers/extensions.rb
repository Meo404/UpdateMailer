class String
  # Check whether or not a string represents an integer
  def is_i?
    /\A[-+]?\d+\z/ === self
  end

  def to_bool
    return true if self=="true"
    return false if self=="false"
    nil
  end
end