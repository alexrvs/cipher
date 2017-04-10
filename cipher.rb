class Cipher

  # encrypt ->  y = x + k(mod n)

  # decrypt -> x = y - k(mod n)

  # x - символ открытого текста
  # y - символ шифрованного текста
  # n - мощность алфавита (количество символов)
  # k - ключ



#ALPHA = ['A','B','C','D','E','F','G','H','I','J','K','L','M','N','O','P','Q','R','S','T','U','V','W','X','Y','Z']

  ALPHA = ('A'..'Z').to_a + ('a'..'z').to_a

  attr_reader :alpha, :keyword, :encryptArr, :encryptArrNew
  attr_writer :keyword, :encryptArr, :encryptArrNew

  def initialize

    @alpha = Array.new
    @encryptArr = []
    @encryptArrNew = []
    @keyword = ''
    @step = ''
  end


  def encrypt(keyword,step)

    step.to_i
    keyword.to_s

    @encryptArr = keyword.chars.to_a

    puts @encryptArr.count
    puts "arr ecrypt"

    ALPHA.each do |symbol|
      @encryptArr.each do |symbolEnc|
        if symbolEnc == symbol
           @encryptArrNew << ALPHA.fetch(ALPHA.index(symbolEnc).to_i + step.to_i)
        end
      end
    end
  end

    def get_encrypt_str
      @encryptArrNew.to_s
      puts @encryptArrNew.join
    end


  def decrypt(secret_key)
    secret_key.to_i

    puts secret_key

    ALPHA.each do |symbol|

    end

  end

end
