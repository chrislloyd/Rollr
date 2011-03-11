module Tuml
  class Parser
    include Temple::Mixins::Options
    
    def compile input
      LangParser.new.parse(input).sexp
    end
  end
end
