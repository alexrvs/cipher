class CipherApp

  # encrypt ->  y = x + k(mod n)

  # decrypt -> x = y - k(mod n)

  # x - символ открытого текста
  # y - символ шифрованного текста
  # n - мощность алфавита (количество символов)
  # k - ключ




  class << self

    def run
      puts "Loadin relative files..."
      require_relative "cipher"

      cipher = Cipher.new

      puts "Введите ключевое слово:"
      keyword = gets.chomp
      puts "Введите ключ в диапазоне он 1 до #{Cipher::COUNT_S.to_i - 1}"
      step = gets.chomp
      unless keyword.empty? && step.empty?
        cipher.encrypt(keyword, step)
      end
      puts "Закодированная строка #{keyword} c ключем #{step}:"
      puts cipher.get_encrypt_str

      puts "Желаете декодировать строку, надеюсь получиться ;) , если вы конечно введете ключ: "
      decryptkey = gets.chomp
      unless decryptkey.empty?
        cipher.decrypt(decryptkey)
      end
    end


    def runTest
      require_relative "cipher"

      cipher = Cipher.new
      puts "Вставте текст, который нужно декодировать без использования ключа:"
      encryptText = gets.chomp
      unless encryptText.empty?
        cipher.crackMsg(encryptText)
      else
        puts "Закодированный текст не может быть пустой строкой"
      end

    end
  end

end