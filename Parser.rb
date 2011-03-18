class Parser
  include Temple::Mixins::Options

  def compile input
    TumlParser.new.parse(input).sexp
  end

end
