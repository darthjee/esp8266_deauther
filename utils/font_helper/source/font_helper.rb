# frozen_string_literal: true

require 'sinclair'

class FontHelper
  autoload :Font, 'font_helper/font'
  autoload :Character, 'font_helper/character'

  autoload :FontBuilder, 'font_helper/font_builder'
  autoload :CharacterBuilder, 'font_helper/character_builder'

  autoload :FontLoader, 'font_helper/font_loader'
  autoload :FileLoader, 'font_helper/file_loader'

  autoload Script, 'font_helper/script'
end
