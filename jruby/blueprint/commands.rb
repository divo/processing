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
        '(' => :open_message,
        ')' => :close_message,
        '[' => :open_node,
        ']' => :close_node,
        '<' => :push,
        '>' => :pop,
        '/' => :arrow_forward, # TODO: Maybe use the push / pop stuff for this?
        '\\' => :arrow_backward
      }
    end
  end
end
