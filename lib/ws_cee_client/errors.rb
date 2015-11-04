module WsCee
  class Error < StandardError
  end

  class ParsingError < Error
  end

  class ConnectionError < Error
  end
end
