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
      palindromes += 1 if (number_and_square_palindrome? n)
    }
    
    palindromes
  end

  def number_and_square_palindrome?(number)
    number_s = number.to_s

    if palindrome? number_s
      square = Math.sqrt(number).to_s
      square_splitted = square.split(".")
      even_square = square_splitted[1] == "0"
      if even_square
        square = square_splitted[0]
        # p "number: #{number_s}  square: #{square}"
        return palindrome?(square)
      end
    end

    false
  end

  def palindrome?(string)
    string == string.reverse
  end

end

m = Miracle.new
m.do_miracle