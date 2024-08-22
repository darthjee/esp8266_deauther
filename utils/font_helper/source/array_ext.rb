class Array
  def ensure_size!(size, default)
    slice!(size, self.size - size)
    fill(default, self.size, size - self.size)
    self
  end
end
