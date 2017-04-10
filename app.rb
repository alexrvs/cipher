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
      puts "Введите кл"
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



  end

end