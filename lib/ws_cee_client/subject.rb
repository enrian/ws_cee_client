module WsCee
  class Subject
    attr_reader :name
    attr_reader :address
    attr_reader :registration_id
    attr_reader :date_of_birth

    def initialize(subject_info_hash)
      @name = subject_info_hash[:name]
      @address = subject_info_hash[:address]
      @registration_id = subject_info_hash[:registration_id]
      @date_of_birth = subject_info_hash[:date_of_birth]
    end
  end
end
