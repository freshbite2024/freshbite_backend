require 'jwt'

module JwtToken
  SECRET_KEY = 'FreshBiteApplication' # Replace with a strong secret key

  # Generate a JWT token
  def generate_token(payload, expiration = 3600)
    payload[:exp] = Time.now.to_i + expiration
    JWT.encode(payload, SECRET_KEY, 'HS256')
  end

  # Decode and verify a JWT token
  def decode_token(token)
    JWT.decode(token, SECRET_KEY, true, { algorithm: 'HS256' }).first
  rescue JWT::ExpiredSignature
    halt 401, { error: 'Token has expired' }.to_json
  rescue JWT::DecodeError
    halt 401, { error: 'Invalid token' }.to_json
  end
end
