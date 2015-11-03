module WsCee
  class CauseInfo
    attr_reader :code
    attr_reader :document_type
    attr_reader :registration_date
    attr_reader :subject

    def initialize(cause_hash)
      @code = cause_hash[:code]
      @document_type = cause_hash[:document_type]
      @registration_date = cause_hash[:registration_date]
      @subject = Subject.new cause_hash[:subject_info]
    end
  end
end
