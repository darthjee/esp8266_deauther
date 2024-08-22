# frozen_string_literal: true

class Array
  def ensure_size!(size, &)
    slice!(size, self.size - size)
    fill(self.size, size - self.size, &)
    self
  end
end
