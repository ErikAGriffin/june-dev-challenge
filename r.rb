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

def second_parent_of(node)
  temp = node.chars
  temp[0] = (temp[0].to_i)-1
  temp.join
end

def first_parent_of(node)
  node.chars.map {|c| (c.to_i)-1}.join
end

def load_triangle2(file)
  result = {}
  File.open(file).each_with_index do |line,rindex|
    line.split(" ").each_with_index do |number, cindex|
      result.store((rindex.to_s+cindex.to_s).to_sym,number.to_i)
    end
  end
  result
end


def least_sum(file)
  paths = {}
  tree = load_triangle2(file)
  tree.each_key do |key|
    path[key] = [tree[key]]

  end

end
