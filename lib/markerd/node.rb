module Markerd
  class Node
    def inspect
      if self.respond_to?(:content)
        '#<' + self.class.to_s + ' content="' + self.content.to_s + '">'
      else
        '#<' + self.class.to_s + '>'
      end
    end
  end

  class AttributeNode
    def to_s
      @name.to_s
    end
  end
end
