class Cipher

  # encrypt ->  y = x + k(mod n)

  # decrypt -> x = y - k(mod n)

  # x - символ открытого текста
  # y - символ шифрованного текста
  # n - мощность алфавита (количество символов)
  # k - ключ

  #ALPHA = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

  @@saved_secret_key = 0

  ALPHA = ('a'..'z').to_a
  COUNT_S = ALPHA.count

  ALPHA_STATISTIC = {
      'a' => 0.0804,
      'b' => 0.0154,
      'c' => 0.0306,
      'd' => 0.0399,
      'e' => 0.1251,
      'f' => 0.0230,
      'g' => 0.0196,
      'h' => 0.0549,
      'i' => 0.0726,
      'j' => 0.0016,
      'k' => 0.0067,
      'l' => 0.0414,
      'm' => 0.0253,
      'n' => 0.0709,
      'o' => 0.0760,
      'p' => 0.0200,
      'q' => 0.0011,
      'r' => 0.0612,
      's' => 0.0654,
      't' => 0.0925,
      'u' => 0.0271,
      'v' => 0.0099,
      'w' => 0.0192,
      'x' => 0.0019,
      'y' => 0.0173,
      'z' => 0.0009
  }


  ALPHA_STATISTIC2 = [0.08167, 0.01492, 0.02782, 0.04253, 0.12702, 0.02228, 0.02015, 0.06094,
                      0.06966, 0.00153, 0.00772, 0.04025, 0.02406, 0.06749, 0.07507, 0.01929,
                      0.00095, 0.05987, 0.06327, 0.09056, 0.02758, 0.00978, 0.02360, 0.00150,
                      0.01974, 0.00074]

  attr_reader :alpha, :keyword, :encryptArr, :encryptArrNew
  attr_writer :keyword, :encryptArr, :encryptArrNew

  def initialize

    @alpha = Array.new
    @encryptArr = []
    @encryptArrNew = []
    @decryptArr = []
    @keyword = ''
    @step = ''
    @decryptKey = 0
  end


  def encrypt(keyword,step)

    @step=step.to_i
    if @step < 0
      @step = step % 26
      @step = step + 26
    end


    @step = step.to_i
    @encryptString = keyword.split("")

    @step.times do
      @encryptString.each do |i|
        if (i.ord >= 97 && i.ord <=122) || (i.ord >= 65 && i.ord <= 90)
          if i.ord == 90
            i.sub!('Z','A')
          elsif i.ord == 122
            i.sub!('z','a')
          else
            i.next!
          end
        end

      end

    end
    @encryptString.to_s
    @encryptString.join

  end

    def get_encrypt_str
      @encryptString.to_s
      puts @encryptString.join
      @@saved_secret_key = @step
    end


  def decrypt(text = '', secret_key)
    @decryptKey = secret_key.to_i

#    if @@saved_secret_key.to_i == @decryptKey

      unless text.empty?
       @encryptArrNew = text.chars.to_a
      end
      @encryptArrNew.each do |symbolDecrypt|
        ALPHA.each do |symbol|
          if symbol == symbolDecrypt

            newDecIndex = ALPHA.index(symbol).to_i - @decryptKey

            @decryptArr << ALPHA.fetch(ALPHA.index(symbolDecrypt).to_i - @decryptKey)
          end
        end
        if symbolDecrypt.to_s.match(/\s/)
          @decryptArr << " "
        end
      end
      @decryptArr.to_s
      puts @decryptArr.join
    else
#      puts "Вы ввели неверный декодировочный ключ, Попробуйте еще раз!)"
#    end

  end

  #   Критерий χ2 ("хи-квадрат", "критерий согласия Пирсона")
  #   χ2=∑(fo−fe)/fe


  def crackMsg(encryptMsg)

    @strToArrForHash = encryptMsg.chars.to_a

    @maxFloat64 = 1.797693134862315708145274237317043567981e+308
    @hash_frequence = Array.new
    sizeStr = @strToArrForHash.length
    @shift = 0

    (0..25).each do |empty| @hash_frequence << empty*0  end

    ('a'..'z').each.with_index do |s , i|
      @strToArrForHash.uniq.select do |c|
        if s == c
          @hash_frequence[i] = (@strToArrForHash.count(c)/sizeStr.to_f)
        end
      end
    end

    (0..26).each do |i|
      chi = check_frequency_encrypt_string(@hash_frequence, i)
      if chi < @maxFloat64
        @maxFloat64 = chi
        @shift = i
      end
    end
    puts @shift
    puts "Ваш текст декодирован :"

    decrypt(encryptMsg, @shift)

  end


  private

    def check_frequency_encrypt_string( frequenciesArr ,rot)


      @sumChiSqrt = 0.0
      @newDefaultHashAlpha = ALPHA_STATISTIC2
      @newDefaultHashAlpha.each.with_index do |defaultValueStat, i|
            encryptValueStat = frequenciesArr[(i+rot)%26]

            @sumChiSqrt += (((encryptValueStat - defaultValueStat) * (encryptValueStat - defaultValueStat)) / defaultValueStat)
      end
        @sumChiSqrt
    end

end
