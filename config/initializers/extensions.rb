class String
  # Check whether or not a string represents an integer
  def is_i?
    /\A[-+]?\d+\z/ === self
  end
end