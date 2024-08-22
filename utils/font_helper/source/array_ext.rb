class Array
  def ensure_size!(size, &block)
    slice!(size, self.size - size)
    fill(self.size, size - self.size, &block)
    self
  end
end
