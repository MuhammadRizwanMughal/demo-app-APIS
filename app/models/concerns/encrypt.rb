module Encrypt
  extend ActiveSupport::Concern

  def encrypt_token(token)
    cipher = OpenSSL::Cipher::AES.new(256, :cbc)
    cipher.encrypt
    cipher.key = 'e058e9db345abca5d90ecf2a8f07cb59'
    cipher.iv = 'E73DA245F5C5EFA5'
    encrypted = cipher.update(token) + cipher.final
    encrypted = Base64.encode64(encrypted).encode('utf-8')
    encrypted
  end

  def decrypt_token(token)
    decoded = Base64.decode64(token).encode('ascii-8bit')
    cipher = OpenSSL::Cipher::AES.new(256, :cbc)
    cipher.decrypt
    cipher.key = 'e058e9db345abca5d90ecf2a8f07cb59'
    cipher.iv = 'E73DA245F5C5EFA5'
    decoded = cipher.update(decoded) + cipher.final
    decoded
  end

end