class TreeParser

  # Also subsequent runs without closing pry causes
  # the process to grow and grow, if my measurement
  # method is sound. Why?

  class << self

    def parse_least_sum(file)
      time = Time.now  # --- Logging
      tree = load_triangle(file)
      tree.each_with_index do |row,rindex|
        row.each_with_index do |number,cindex|
          node = find_smallest_parent(rindex,cindex,tree) || 0
          node+= number
          row[cindex] = node
        end
      end
      puts Time.now - time # --- Logging
      puts `ps -o rss -p #{$$}`.strip.split.last.to_i * 1024 # --- Logging
      tree.last.inject{|min,node| min > node ? node : min}
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

    def find_smallest_parent(rindex,cindex,tree)
      return if rindex-1 < 0
      left = tree[rindex-1][cindex-1] if cindex-1 >= 0
      right = tree[rindex-1][cindex]
      if left && right
        left < right ? left : right
      else
        left ? left : right
      end
    end

  end
end
