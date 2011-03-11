module Tuml
  module Filters
    class BlockFilter < Temple::Filter

      def on_multi *nodes
        block, buffer = false, [:multi]

        nodes.inject([]) do |result, node|
          if node.first == :sblock and not block
            block = [:block, *node[1..-1]]

          elsif node.first == :eblock and block and block[1] == node[1]
            block << compile!(buffer)
            result << block

            block, buffer = false, [:multi]

          else
            (block ? buffer : result) << node

          end

          result
        end.unshift :multi
      end


    end
  end
end
