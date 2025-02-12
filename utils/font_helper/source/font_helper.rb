# frozen_string_literal: true

require 'sinclair'
require 'array_ext'

class FontHelper
  autoload :Font,      'font_helper/font'
  autoload :Character, 'font_helper/character'

  autoload :FontBuilder,      'font_helper/font_builder'
  autoload :CharacterBuilder, 'font_helper/character_builder'

  autoload :FontLoader, 'font_helper/font_loader'
  autoload :FileLoader, 'font_helper/file_loader'

  autoload :BitMap,                 'font_helper/bit_map'
  autoload :BinaryConverter,        'font_helper/binary_converter'
  autoload :FontWritter,            'font_helper/font_writter'
  autoload :CharacterWritter,       'font_helper/character_writter'
  autoload :CharacterBinaryWritter, 'font_helper/character_binary_writter'

  autoload :ImageWritter, 'font_helper/image_writter'
  autoload :ImageReader,  'font_helper/image_reader'

  autoload :Script,        'font_helper/script'
  autoload :ScriptContext, 'font_helper/script_context'
  autoload :Command,       'font_helper/command'
end
