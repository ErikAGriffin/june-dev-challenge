class TreeParser

  # Handle Double (or even triple!) digit rows!!!

  attr_reader :paths

  def initialize
    @paths = {}
  end

  def load_triangle(file)
    result = []
    File.open(file).each do |line|
      row = []
      line.split(" ").each do |number|
        row << number.to_i
      end
      result << row
    end
    result
  end

  def find_left_parent(key)
    puts "key: #{key}"
    array = key.to_s.chars
    key1 = []
    key2 = []
    array.each_with_index do |number, index|
      index < (array.length/2.0).ceil ? key1 << number : key2 << number
    end
    puts "row: #{key1.join} col: #{key2.join}"
  end

  def least_sum2(file)
    @paths = {}
    time = Time.now
    tree = load_triangle(file)
    tree.each_with_index do |row,rindex|
      row.each_with_index do |number,cindex|
        # Ahh if I just do rindex+cindex for the hash keys,
        # could I get collisions??
        key = (rindex.to_s+cindex.to_s).to_sym
        paths[key] = true
        find_left_parent(key)
      end
    end
    puts Time.now - time
    puts `ps -o rss -p #{$$}`.strip.split.last.to_i * 1024
  end

  def least_sum(file)
    @paths = {}
    time = Time.now
    tree = load_triangle2(file)
    tree.each_key do |key|
      path = (find_smallest_parent(key).dup if find_smallest_parent(key)) || []
      # path = path.dup
      path << tree[key]
      paths[key] = path
    end
    puts Time.now - time
    puts `ps -o rss -p #{$$}`.strip.split.last.to_i * 1024
  end




  # Dear god refactor..

  def second_parent_of(node)
    temp =node.to_s.chars[0..3].join.to_i-1
    key1 = [0,0,0]
    key1 << temp
    key1 = key1.join.chars[-4..-1].join
    (key1+(node.to_s.chars[-4..-1].join)).to_sym
  end

  def first_parent_of(node)
    temp =node.to_s.chars[0..3].join.to_i-1
    key1 = [0,0,0]
    key2 = [0,0,0]
    key1 << temp
    key1 = key1.join.chars[-4..-1].join
    temp = node.to_s.chars[-4..-1].join.to_i-1
    key2 << temp
    key2 = key2.join.chars[-4..-1].join
    (key1+key2).to_sym
  end

  def load_triangle2(file)
    result = {}
    File.open(file).each_with_index do |line,rindex|
      line.split(" ").each_with_index do |number, cindex|
        key1 = [0,0,0]
        key2 = [0,0,0]
        key1 << rindex
        key2 << cindex
        key1 = key1.join.chars[-4..-1].join
        key2 = key2.join.chars[-4..-1].join
        result.store((key1+key2).to_sym,number.to_i)
      end
    end
    result
  end

  def find_smallest_parent(node)
    first = first_parent_of(node)
    second = second_parent_of(node)
    ret = nil
    if paths[first] && paths[second]
      ret = paths[first].inject{|sum,x| sum + x } < paths[second].inject{|sum,x| sum + x } ? paths[first] : paths[second]
    elsif paths[second]
      ret = paths[second]
    elsif paths[first]
      ret = paths[first]
    end
    ret
  end

end
