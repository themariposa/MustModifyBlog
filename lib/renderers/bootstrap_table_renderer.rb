module Renderers
  module BootstrapTableRenderer
    def table(head, body)
      %|<table class="table"><thead>#{head}</thead><tbody>#{body}</tbody></table>| 
    end
  end
end
