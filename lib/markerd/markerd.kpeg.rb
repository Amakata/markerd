require 'kpeg/compiled_parser'

class Markerd::Parser < KPeg::CompiledParser


  # 抽象構文木のプロパティを追加
  attr_reader :ast

  # コンパイラから位置情報を取得するクラス
  # posが現在の位置、lineが現在の行、colが現在の列
  class Position
    attr_accessor :pos, :line, :col
    def initialize(compiler)
      @pos = compiler.pos
      @line = compiler.current_line
      @col = compiler.current_column
    end
  end

  # 現在の位置を取得するメソッド。ASTのノードを呼び出すときに第２引数で使う
  def position
    Position.new(self)
  end


  # :stopdoc:

  module ::Markerd
    class Node; end
    class AttributeNode < Node
      def initialize(compiler, position, name, value)
        @compiler = compiler
        @position = position
        @name = name
        @value = value
      end
      attr_reader :compiler
      attr_reader :position
      attr_reader :name
      attr_reader :value
    end
    class DocumentNode < Node
      def initialize(compiler, position, content)
        @compiler = compiler
        @position = position
        @content = content
      end
      attr_reader :compiler
      attr_reader :position
      attr_reader :content
    end
    class EntityNode < Node
      def initialize(compiler, position, content)
        @compiler = compiler
        @position = position
        @content = content
      end
      attr_reader :compiler
      attr_reader :position
      attr_reader :content
    end
    class EntityItemNode < Node
      def initialize(compiler, position, content)
        @compiler = compiler
        @position = position
        @content = content
      end
      attr_reader :compiler
      attr_reader :position
      attr_reader :content
    end
    class RelationshipNode < Node
      def initialize(compiler, position, content)
        @compiler = compiler
        @position = position
        @content = content
      end
      attr_reader :compiler
      attr_reader :position
      attr_reader :content
    end
    class TitleNode < Node
      def initialize(compiler, position, content)
        @compiler = compiler
        @position = position
        @content = content
      end
      attr_reader :compiler
      attr_reader :position
      attr_reader :content
    end
  end
  module ::MarkerdConstruction
    def attribute(compiler, position, name, value)
      ::Markerd::AttributeNode.new(compiler, position, name, value)
    end
    def document(compiler, position, content)
      ::Markerd::DocumentNode.new(compiler, position, content)
    end
    def entity(compiler, position, content)
      ::Markerd::EntityNode.new(compiler, position, content)
    end
    def entity_item(compiler, position, content)
      ::Markerd::EntityItemNode.new(compiler, position, content)
    end
    def relationship(compiler, position, content)
      ::Markerd::RelationshipNode.new(compiler, position, content)
    end
    def title(compiler, position, content)
      ::Markerd::TitleNode.new(compiler, position, content)
    end
  end
  include ::MarkerdConstruction

  # root = Start
  def _root
    _tmp = apply(:_Start)
    set_failed_rule :_root unless _tmp
    return _tmp
  end

  # Start = &. Doc:c { @ast = c  }
  def _Start

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = get_byte
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Doc)
      c = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  @ast = c  ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Start unless _tmp
    return _tmp
  end

  # Doc = Element+:c {document(self, position, c)}
  def _Doc

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _ary = []
      _tmp = apply(:_Element)
      if _tmp
        _ary << @result
        while true
          _tmp = apply(:_Element)
          _ary << @result if _tmp
          break unless _tmp
        end
        _tmp = true
        @result = _ary
      else
        self.pos = _save1
      end
      c = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; document(self, position, c); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Doc unless _tmp
    return _tmp
  end

  # Element = Title
  def _Element
    _tmp = apply(:_Title)
    set_failed_rule :_Element unless _tmp
    return _tmp
  end

  # Title = "title" Sp "{" TitleAttributes:c "}" {title(self, position, c)}
  def _Title

    _save = self.pos
    while true # sequence
      _tmp = match_string("title")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("{")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_TitleAttributes)
      c = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("}")
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; title(self, position, c); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Title unless _tmp
    return _tmp
  end

  # TitleAttributes = TitleAttribute:c ("," TitleAttribute)*:cc { cc.unshift c }
  def _TitleAttributes

    _save = self.pos
    while true # sequence
      _tmp = apply(:_TitleAttribute)
      c = @result
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true

        _save2 = self.pos
        while true # sequence
          _tmp = match_string(",")
          unless _tmp
            self.pos = _save2
            break
          end
          _tmp = apply(:_TitleAttribute)
          unless _tmp
            self.pos = _save2
          end
          break
        end # end sequence

        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      cc = @result
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  cc.unshift c ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TitleAttributes unless _tmp
    return _tmp
  end

  # TitleAttribute = BlankLine* (Label | Size)
  def _TitleAttribute

    _save = self.pos
    while true # sequence
      while true
        _tmp = apply(:_BlankLine)
        break unless _tmp
      end
      _tmp = true
      unless _tmp
        self.pos = _save
        break
      end

      _save2 = self.pos
      while true # choice
        _tmp = apply(:_Label)
        break if _tmp
        self.pos = _save2
        _tmp = apply(:_Size)
        break if _tmp
        self.pos = _save2
        break
      end # end choice

      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_TitleAttribute unless _tmp
    return _tmp
  end

  # Label = Sp "label:" Sp "\"" "a"*:value "\"" Sp {attribute(self, position, 'label', value)}
  def _Label

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("label:")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      _ary = []
      while true
        _tmp = match_string("a")
        _ary << @result if _tmp
        break unless _tmp
      end
      _tmp = true
      @result = _ary
      value = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; attribute(self, position, 'label', value); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Label unless _tmp
    return _tmp
  end

  # Size = Sp "size:" Sp "\"" Digits:value "\"" Sp {attribute(self, position, 'size', value)}
  def _Size

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("size:")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Digits)
      value = @result
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = match_string("\"")
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin; attribute(self, position, 'size', value); end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Size unless _tmp
    return _tmp
  end

  # Digits = < Digit+ > { text }
  def _Digits

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _save1 = self.pos
      _tmp = apply(:_Digit)
      if _tmp
        while true
          _tmp = apply(:_Digit)
          break unless _tmp
        end
        _tmp = true
      else
        self.pos = _save1
      end
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Digits unless _tmp
    return _tmp
  end

  # Entity = !.
  def _Entity
    _save = self.pos
    _tmp = get_byte
    _tmp = _tmp ? nil : true
    self.pos = _save
    set_failed_rule :_Entity unless _tmp
    return _tmp
  end

  # Relationship = !.
  def _Relationship
    _save = self.pos
    _tmp = get_byte
    _tmp = _tmp ? nil : true
    self.pos = _save
    set_failed_rule :_Relationship unless _tmp
    return _tmp
  end

  # BlankLine = Sp Newline
  def _BlankLine

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _tmp = apply(:_Newline)
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_BlankLine unless _tmp
    return _tmp
  end

  # Sp = Spacechar*
  def _Sp
    while true
      _tmp = apply(:_Spacechar)
      break unless _tmp
    end
    _tmp = true
    set_failed_rule :_Sp unless _tmp
    return _tmp
  end

  # Spnl = Sp (Newline Sp)?
  def _Spnl

    _save = self.pos
    while true # sequence
      _tmp = apply(:_Sp)
      unless _tmp
        self.pos = _save
        break
      end
      _save1 = self.pos

      _save2 = self.pos
      while true # sequence
        _tmp = apply(:_Newline)
        unless _tmp
          self.pos = _save2
          break
        end
        _tmp = apply(:_Sp)
        unless _tmp
          self.pos = _save2
        end
        break
      end # end sequence

      unless _tmp
        _tmp = true
        self.pos = _save1
      end
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Spnl unless _tmp
    return _tmp
  end

  # Spacechar = < / |\t/ > { text }
  def _Spacechar

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?-mix: |\t)/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Spacechar unless _tmp
    return _tmp
  end

  # Nonspacechar = !Spacechar !Newline < . > { text }
  def _Nonspacechar

    _save = self.pos
    while true # sequence
      _save1 = self.pos
      _tmp = apply(:_Spacechar)
      _tmp = _tmp ? nil : true
      self.pos = _save1
      unless _tmp
        self.pos = _save
        break
      end
      _save2 = self.pos
      _tmp = apply(:_Newline)
      _tmp = _tmp ? nil : true
      self.pos = _save2
      unless _tmp
        self.pos = _save
        break
      end
      _text_start = self.pos
      _tmp = get_byte
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Nonspacechar unless _tmp
    return _tmp
  end

  # Newline = ("\n" | "\r" "\n"?)
  def _Newline

    _save = self.pos
    while true # choice
      _tmp = match_string("\n")
      break if _tmp
      self.pos = _save

      _save1 = self.pos
      while true # sequence
        _tmp = match_string("\r")
        unless _tmp
          self.pos = _save1
          break
        end
        _save2 = self.pos
        _tmp = match_string("\n")
        unless _tmp
          _tmp = true
          self.pos = _save2
        end
        unless _tmp
          self.pos = _save1
        end
        break
      end # end sequence

      break if _tmp
      self.pos = _save
      break
    end # end choice

    set_failed_rule :_Newline unless _tmp
    return _tmp
  end

  # AlphanumericAscii = < /[A-Za-z0-9]/ > { text }
  def _AlphanumericAscii

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?-mix:[A-Za-z0-9])/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_AlphanumericAscii unless _tmp
    return _tmp
  end

  # Digit = < /[0-9]/ > { text }
  def _Digit

    _save = self.pos
    while true # sequence
      _text_start = self.pos
      _tmp = scan(/\A(?-mix:[0-9])/)
      if _tmp
        text = get_text(_text_start)
      end
      unless _tmp
        self.pos = _save
        break
      end
      @result = begin;  text ; end
      _tmp = true
      unless _tmp
        self.pos = _save
      end
      break
    end # end sequence

    set_failed_rule :_Digit unless _tmp
    return _tmp
  end

  Rules = {}
  Rules[:_root] = rule_info("root", "Start")
  Rules[:_Start] = rule_info("Start", "&. Doc:c { @ast = c  }")
  Rules[:_Doc] = rule_info("Doc", "Element+:c {document(self, position, c)}")
  Rules[:_Element] = rule_info("Element", "Title")
  Rules[:_Title] = rule_info("Title", "\"title\" Sp \"{\" TitleAttributes:c \"}\" {title(self, position, c)}")
  Rules[:_TitleAttributes] = rule_info("TitleAttributes", "TitleAttribute:c (\",\" TitleAttribute)*:cc { cc.unshift c }")
  Rules[:_TitleAttribute] = rule_info("TitleAttribute", "BlankLine* (Label | Size)")
  Rules[:_Label] = rule_info("Label", "Sp \"label:\" Sp \"\\\"\" \"a\"*:value \"\\\"\" Sp {attribute(self, position, 'label', value)}")
  Rules[:_Size] = rule_info("Size", "Sp \"size:\" Sp \"\\\"\" Digits:value \"\\\"\" Sp {attribute(self, position, 'size', value)}")
  Rules[:_Digits] = rule_info("Digits", "< Digit+ > { text }")
  Rules[:_Entity] = rule_info("Entity", "!.")
  Rules[:_Relationship] = rule_info("Relationship", "!.")
  Rules[:_BlankLine] = rule_info("BlankLine", "Sp Newline")
  Rules[:_Sp] = rule_info("Sp", "Spacechar*")
  Rules[:_Spnl] = rule_info("Spnl", "Sp (Newline Sp)?")
  Rules[:_Spacechar] = rule_info("Spacechar", "< / |\\t/ > { text }")
  Rules[:_Nonspacechar] = rule_info("Nonspacechar", "!Spacechar !Newline < . > { text }")
  Rules[:_Newline] = rule_info("Newline", "(\"\\n\" | \"\\r\" \"\\n\"?)")
  Rules[:_AlphanumericAscii] = rule_info("AlphanumericAscii", "< /[A-Za-z0-9]/ > { text }")
  Rules[:_Digit] = rule_info("Digit", "< /[0-9]/ > { text }")
  # :startdoc:
end
