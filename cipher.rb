class Cipher

  # encrypt ->  y = x + k(mod n)

  # decrypt -> x = y - k(mod n)

  # x - символ открытого текста
  # y - символ шифрованного текста
  # n - мощность алфавита (количество символов)
  # k - ключ



#ALPHA = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

  @@saved_secret_key = 0

  ALPHA = ('A'..'Z').to_a + ('a'..'z').to_a

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

    puts @encryptArr.count
    puts "arr ecrypt"


      @encryptArr.each do |symbolEnc|
        ALPHA.each do |symbol|
          if symbolEnc == symbol
            puts "symbol ---- #{symbol}"
            sleep(1)

             newDecIndex = ALPHA.index(symbol).to_i + step.to_i

              puts "find symbol ---- #{ ALPHA.fetch(newDecIndex)}"
              sleep(1)
             @encryptArrNew << ALPHA.fetch(newDecIndex)

          end
      end
    end
    p @encryptArrNew
    p @encryptArrNew.to_s
    p @encryptArrNew.join
  end

    def get_encrypt_str
      @encryptArrNew.to_s
      puts @encryptArrNew.join
      if @encryptArrNew.kind_of?(String) && @encryptArrNew.length >0

      end
      puts "saved key in encrypt func"
      puts @@saved_secret_key
      @@saved_secret_key = @step
    end


  def decrypt(secret_key)
    @decryptKey = secret_key.to_i

    puts @decryptKey.kind_of?(Numeric)
    puts "saved key -------------"
    puts @@saved_secret_key.kind_of?(Numeric)

    if @@saved_secret_key.to_i == @decryptKey

      @encryptArrNew.each do |symbolDecrypt|
        ALPHA.each do |symbol|
          if symbol == symbolDecrypt

            puts "symbol ---- #{symbol}"
            sleep(1)

            newDecIndex = ALPHA.index(symbol).to_i - @decryptKey

            puts "find symbol ---- #{ ALPHA.fetch(newDecIndex)}"
            sleep(1)


            @decryptArr << ALPHA.fetch(ALPHA.index(symbolDecrypt).to_i - @decryptKey)
          end
        end
      end
      @decryptArr.to_s
      puts @decryptArr.join
    else
      puts "Вы ввели неверный декодировочный ключ, Попробуйте еще раз!)"
    end

  end

end
