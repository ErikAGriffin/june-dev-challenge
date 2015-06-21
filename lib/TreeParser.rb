class TreeParser

  # Also subsequent runs without closing pry causes
  # the process to grow and grow, if my measurement
  # method is sound. Why?

  class << self

    def least_sum(file)
      paths = {}
      time = Time.now  # --- Logging
      tree = load_triangle(file)
      tree.each_with_index do |row,rindex|
        row.each_with_index do |number,cindex|
          key = (rindex.to_s+cindex.to_s).to_sym
          path = (find_smallest_parent(key,paths).dup if find_smallest_parent(key,paths)) || []
          path << number
          paths[key] = path
        end
      end
      puts Time.now - time # --- Logging
      puts `ps -o rss -p #{$$}`.strip.split.last.to_i * 1024 # --- Logging
      # vvvvvvv Really need to refactor this vvvvvv
    end

    protected

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



    def find_smallest_parent(key,paths)
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

end
