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



  end

end
