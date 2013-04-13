class Miracle

  def do_miracle
    f = File.new("sample.input")

    cases = Array.new
    one_case = Array.new

    line_num = 0
    cases_num = 0

    f.each_line { |line|
      line_num += 1
      # puts "reading line[#{line_num}]: #{line}"
      
      if line_num == 1
        cases_num = line.to_i
        puts "Number of cases: #{cases_num}"
      else
        if line == "\n"
          cases << one_case unless cases.length > cases_num
          one_case = Array.new
        else
          one_case << line
        end
      end
    }

    puts "Total cases read: #{cases.length}"


    case_num = 0
    cases.map { |one_case| 
      case_num += 1

      result = analyze one_case
      puts "Case ##{case_num}: #{result}"
    }
  end

  def analyze(one_case)

    dots_count = 0

    #rows
    one_case.each { |row|
      count = count_x_o_t row
      if count[0] == 4 || (count[0] == 3 && count[2] == 1)
        return "X won"
      elsif count[1] == 4 || (count[1] == 3 && count[2] == 1)
        return "O won"
      else
        dots_count =+ count[3]
      end
    }


    # columns
    (0...4).step(1) { |col|
      column = Array.new(4)
      (0...4).step(1) { |row|
        column << (one_case[row])[col]
      }
      
      count = count_x_o_t column.join
      if count[0] == 4 || (count[0] == 3 && count[2] == 1)
        return "X won"
      elsif count[1] == 4 || (count[1] == 3 && count[2] == 1)
        return "O won"
      end
      column = nil 
    }


    # diagonal
    diagonal = [one_case[0][0], one_case[1][1], one_case[2][2], one_case[3][3]]
    count = count_x_o_t diagonal.join
    if count[0] == 4 || (count[0] == 3 && count[2] == 1)
      return "X won"
    elsif count[1] == 4 || (count[1] == 3 && count[2] == 1)
      return "O won"
    end

    # off_diagonal
    off_diagonal = [one_case[0][3], one_case[1][2], one_case[2][1], one_case[3][0]]
    count = count_x_o_t off_diagonal.join
    if count[0] == 4 || (count[0] == 3 && count[2] == 1)
      return "X won"
    elsif count[1] == 4 || (count[1] == 3 && count[2] == 1)
      return "O won"
    end


    return "Game has not completed" if dots_count > 0
    
    "Draw"
  end

  def count_x_o_t(array)
    #       [X, O, T, .]
    count = [0, 0, 0, 0]
    array.each_char { |ch|
      if ch == "X"
        count[0] += 1
      elsif ch == "O"
        count[1] += 1
      elsif ch == "T"
        count[2] += 1
      elsif ch == "."
        count[3] += 1
      end
    }
    count
  end

end

m = Miracle.new
m.do_miracle