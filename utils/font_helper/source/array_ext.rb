# frozen_string_literal: true

class Array
  def ensure_size!(size, &)
    slice!(size, self.size - size)
    fill(self.size, size - self.size, &)
    self
  end

  def swap(first_index, second_index)
    aux = self[first_index]
    self[first_index] = self[second_index]
    self[second_index] = aux
  end
end
