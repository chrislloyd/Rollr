class Template < Temple::Template
  engine Engine
end

Tilt.register :tuml, Template
