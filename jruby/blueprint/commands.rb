module Blueprint
  module Commands
    def movement_commands
      {
        'h' => :left,
        'l' => :right
      }
    end

    def commands
      #  Old commands
      #  ' ' => :space
      #  ',' => :down_45
      #  '.' => :up_90
      #  '1' => :up_45
      #  '2' => :questionmark
      {
        ' ' => :space,
        '.' => :down_45,
        ',' => :up_45,
        '<' => :push,
        '>' => :pop,
        '/' => :arrow_forward, # TODO: Maybe use the push / pop stuff for this?
        '\\' => :arrow_backward,
        ':' => :state
      }.merge(node_commands)
    end

    def node_commands
      {
        '(' => :open_message,
        ')' => :close_message,
        '[' => :open_node,
        ']' => :close_node,
      }
    end
  end
end
