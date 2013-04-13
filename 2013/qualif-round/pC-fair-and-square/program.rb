class Miracle

  def do_miracle
    f = File.new("input.sample")

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
        one_case = line.split(" ")
        cases << one_case unless cases.length > cases_num
      end
    }

    puts "Total cases read: #{cases.length}"

    File.open('output.sample-generated', 'w') do |out|
      num = 0
      cases.map { |one_case| 
        num += 1

        result = analyze one_case
        puts "Case ##{num}: #{result}"
        out.puts "Case ##{num}: #{result}"
      }
    end
  end

  def analyze(one_case)
    palindromes = 0
    (one_case[0].to_i..one_case[1].to_i).step(1) { |n| 
      palindromes += 1 if (palindrome? n)
    }
    
    palindromes
  end

  def palindrome?(number)
    number_s = number.to_s
    square = Math.sqrt(number).to_s
    even_square = (square.split(".")[1] == "0")
    if number_s.size == 1 && even_square
      return true
    else
      if even_square
        square = square.split(".")[0]
        # p "number: #{number_s}  square: #{square}"
        if number_s == number_s.reverse && square == square.reverse
          return true
        end
      end  
    end

    false
  end

end

m = Miracle.new
m.do_miracle