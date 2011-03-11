module Tuml
  class Engine < Temple::Engine
    use Parser

    use Filters::ScopeFilter
    use Filters::BlockFilter

    use Generator
  end
end
