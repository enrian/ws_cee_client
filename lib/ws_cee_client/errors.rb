module WsCee
  SAVON_ERRORS = [Savon::Error, Errno::ECONNREFUSED, SocketError]

  class Error < StandardError
  end

  class ParsingError < Error
  end

  class ConnectionError < Error
  end
end
