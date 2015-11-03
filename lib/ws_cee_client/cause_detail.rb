module WsCee
  class CauseDetail
    attr_reader :code
    attr_reader :description
    attr_reader :documents

    def initialize(cause_detail_hash)
      @code = cause_detail_hash[:code]
      @description = cause_detail_hash[:description]

      @documents = []
      parse_document cause_detail_hash[:document]
    end

    private

    def parse_document(document_hash)
      if document_hash.is_a? Array
        @documents = document_hash.collect { |document| Document.new document }
      else
        @documents << Document.new(document_hash)
      end
    end
  end
end
