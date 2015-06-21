class TreeParser

  class << self

    def parse_least_sum(file)
      tree = load_triangle(file)
      tree.each_with_index do |row,rindex|
        row.each_with_index do |node,cindex|
          row[cindex] = (find_smallest_parent(rindex,cindex,tree) || 0) + node
        end
      end
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
