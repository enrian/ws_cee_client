module WsCee
  class Document
    attr_reader :type
    attr_reader :description
    attr_reader :executor_company
    attr_reader :court
    attr_reader :reference_number
    attr_reader :issue_date
    attr_reader :one_time_price
    attr_reader :regular_price
    attr_reader :non_monetary
    attr_reader :subjects

    def initialize(document_hash)
      @type = document_hash[:type]
      @description = document_hash[:description]
      @executor_company = document_hash[:executor_company]
      @court = document_hash[:court]
      @reference_number = document_hash[:reference_number]
      @issue_date = document_hash[:issue_date]
      @one_time_price = document_hash[:one_time_price]
      @regular_price = document_hash[:regular_price]
      @non_monetary = document_hash[:non_monetary]

      @subjects = []
      parse_subject document_hash[:subject]
    rescue NoMethodError
      raise WsCee::ParsingError
    end

    private

    def parse_subject(subject_hash)
      if subject_hash.is_a? Array
        @subjects = subject_hash.collect { |subject| Subject.new subject }
      else
        @subjects << Subject.new(subject_hash)
      end
    end
  end
end
