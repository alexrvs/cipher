class Cipher

  # encrypt ->  y = x + k(mod n)

  # decrypt -> x = y - k(mod n)

  # x - символ открытого текста
  # y - символ шифрованного текста
  # n - мощность алфавита (количество символов)
  # k - ключ



#ALPHA = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

  @@saved_secret_key = 0

  #ALPHA = ('A'..'Z').to_a + ('a'..'z').to_a

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

    @step = step.to_i
    keyword.to_s


    @encryptArr = keyword.chars.to_a
      p @encryptArr

      @encryptArr.each do |symbolEnc|
        ALPHA.each do |symbol|
          if symbolEnc == symbol
             newDecIndex = ALPHA.index(symbol).to_i + step.to_i
               @encryptArrNew << ALPHA.fetch(newDecIndex)
          end
        end
        if symbolEnc.to_s.match(/\s/)
          @encryptArrNew << " "
        end
    end
    @encryptArrNew
    @encryptArrNew.to_s
    @encryptArrNew.join
  end

    def get_encrypt_str
      @encryptArrNew.to_s
      puts @encryptArrNew.join
      if @encryptArrNew.kind_of?(String) && @encryptArrNew.length > 0

      end
      @@saved_secret_key = @step
    end


  def decrypt(secret_key)
    @decryptKey = secret_key.to_i

    if @@saved_secret_key.to_i == @decryptKey

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
      puts "Вы ввели неверный декодировочный ключ, Попробуйте еще раз!)"
    end

  end

  def decrypt_without_key

    # 1. частотный анализ
    # 2. декартово произведение
    # 3. завершение простого компонента

    # Буквы с наибольшей частотой в криптотексте заменяются на букву с наибольшей частотой из алфавита.
    # Вероятность успешного вскрытия повышается с увеличением длины криптотекста.

    #ALPHA_STATISTIC.map {|el| puts el}

    # might actually be incorrect array art  - original text, "njhiu bduvbmmz cf jodpssfdu bssbz bsu"  - decrypt word
    # attackatonce - original word, "cvvcemcvqpeg" - decrypt word


    encryptStr = "njhiu bduvbmmz cf jodpssfdu bssbz bsu"

    check_frequency_encrypt_string(encryptStr)
    exit(1)
    @encryptArrWKey =  encryptStr.chars.to_a

    ALPHA_STATISTIC.each {|key,value|  "#{key} => #{value}" }

    puts "decrypt without key"
    puts "|_____________________|"

    ALPHA_STATISTIC.each do |key,value|

      @encryptArrWKey.each do |encryptSymbol|
         if key == encryptSymbol
            puts key

        end
      end

    end
    puts "|_____________________|"

    #puts ALPHA_STATISTIC.keys
  end


  private

    def check_frequency_encrypt_string(str)

      @hash_frequence = Hash.new
      @strToArrForHash = str.chars.to_a
      p @strToArrForHash

      sizeStr = @strToArrForHash.length

      @strToArrForHash.uniq.select { |c|  @hash_frequence["#{c}"] = (@strToArrForHash.count(c)/sizeStr.to_f).round(4)  }
      puts @hash_frequence

      @newDefaultHashAlpha = ALPHA_STATISTIC
      @newDecryptArr = []

      #@newDefaultHashAlpha.each  do |defaultKeyStat, defaultValueStat|

        @hash_frequence.each do |encryptKeyStat, encryptValueStat|

          maxEncryptValue = @hash_frequence.values.max
          keyEncrypt = @hash_frequence.key(maxEncryptValue)

          maxDefaultValue = @newDefaultHashAlpha.values.max
          key = @newDefaultHashAlpha.key(maxDefaultValue)

          @strToArrForHash.each do |oldEl|
            if oldEl == keyEncrypt
              @strToArrForHash[@strToArrForHash.index(keyEncrypt)] = key
            end

          end
          #@newDefaultHashAlpha.delete_if {|keyD, value| keyD == key }
          #@hash_frequence.delete_if {|keyE, value|   keyE == keyEncrypt}
        end

      #end

      p @strToArrForHash

    end

end
