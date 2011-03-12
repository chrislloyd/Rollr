class ScopeFilter < Temple::Filter

  def on_multi *nodes
    stack = []

    result = nodes.inject([]) do |result, node|
      if node[0] == :sblock
        if stack.last == node[1]
          node[0] = :eblock
        else
          stack << node[1]
        end
      end

      if node[0] == :eblock
        if stack.last == node[1]
          stack.pop
        else
          next(result)
        end
      end

      result << node
    end.unshift :multi

    stack.reverse.inject(result) do |r, context|
      r << [:eblock, context]
      r
    end
  end

end
