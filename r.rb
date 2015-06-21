class OldTreeParser

  attr_reader :paths

  # ToDo : Make this all just class methods.
  # ...(how to incorporate the helper methods..?)
  # Get rid of paths instance variable.

  # Also subsequent runs without closing pry causes
  # the process to grow and grow, if my measurement
  # method is sound.

  def initialize
    @paths = {}
  end

  def load_triangle(file)
    result = []
    File.open(file).each do |line|
      row = []
      line.split(" ").each {|number| row << number.to_i }
      result << row
    end
    result
  end

  def find_left_parent(key)
    array = key.to_s.chars
    key1 = []
    key2 = []
    array.each_with_index do |number, index|
      index < (array.length/2.0).ceil ? key1 << number : key2 << number
    end
    key1 = key1.join.to_i-1
    key2 = key2.join.to_i-1
    (key1.to_s+key2.to_s).to_sym
  end

  def find_right_parent(key)
    array = key.to_s.chars
    key1 = []
    key2 = []
    array.each_with_index do |number,index|
      index < (array.length/2.0).ceil ? key1 << number : key2 << number
    end
    key1 = key1.join.to_i-1
    (key1.to_s+key2.join).to_sym
  end

  def least_sum(file)
    @paths = {}
    time = Time.now
    tree = load_triangle(file)
    tree.each_with_index do |row,rindex|
      row.each_with_index do |number,cindex|
        key = (rindex.to_s+cindex.to_s).to_sym
        # This may be cause of some memory leak..
        path = (find_smallest_parent(key).dup if find_smallest_parent(key)) || []
        path << number
        paths[key] = path
      end
    end
    puts Time.now - time
    puts `ps -o rss -p #{$$}`.strip.split.last.to_i * 1024
    # vvvvvvv Really need to refactor this vvvvvv
    last_row = (tree.length-1).to_s
    last_row_first = (last_row+'0').to_sym
    minpath = paths[last_row_first] if paths[last_row_first]
    for i in 0..tree.length-1
      current_path = paths[(last_row+i.to_s).to_sym]
      minpath.inject{|sum,x|sum+x} > current_path.inject{|sum,x|sum+x} ? (minpath = current_path) : minpath
    end
    minpath
  end

  def find_smallest_parent(key)
    left = find_left_parent(key)
    right = find_right_parent(key)
    result = nil
    if paths[left] && paths[right]
      result = paths[left].inject{|sum,x| sum+x} < paths[right].inject{|sum,x| sum+x} ? paths[left] : paths[right]
    elsif paths[left]
      result = paths[left]
    elsif paths[right]
      result = paths[right]
    end
    result
  end

end
