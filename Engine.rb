class Engine < Temple::Engine
  use Parser

  use ScopeFilter
  use BlockFilter

  use Generator
end
