require 'rubygems'
require 'savon'

require 'ws_cee_client/errors'
require 'ws_cee_client/cause_detail'
require 'ws_cee_client/cause_info'
require 'ws_cee_client/document'
require 'ws_cee_client/subject'

module WsCee
  class Client
    WS_CEE_TESTING_URL = 'https://source.bisnode.cz/services/cee_fix/v001/soap?wsdl'
    WS_CEE_PRODUCTION_URL = 'https://source.bisnode.cz/services/cee_fix/v001/soap?wsdl' # FIXME

    attr_reader :username
    attr_reader :password
    attr_reader :proxy

    def initialize(options)
      @username = options[:username]
      @password = options[:password]
      @proxy = options[:proxy]

      @savon = Savon.client do
        wsdl options[:testing] ? WS_CEE_PRODUCTION_URL : WS_CEE_TESTING_URL
        proxy @proxy if !@proxy.nil? && !@proxy.empty?
      end
    rescue *SAVON_ERRORS
      raise WsCee::ConnectionError
    end

    def find_by_company(company_details)
      company_indication company_details
    end

    def find_by_person(person_details)
      person_indication person_details
    end

    def cause_detail(options)
      detail options[:cause_code]
    end

    private

    def company_indication(company_details)
      response = @savon.call :indication, message: company_query(company_details)
      parse_indication_response response.hash
    rescue *SAVON_ERRORS
      raise WsCee::ConnectionError
    end

    def person_indication(person_details)
      response = @savon.call :indication, message: person_query(person_details)
      parse_indication_response response.hash
    rescue *SAVON_ERRORS
      raise WsCee::ConnectionError
    end

    def parse_indication_response(hash)
      result = hash[:envelope][:body][:indication_result]
      return [] if result.nil?

      cause_info = result[:cause_info]
      if cause_info.is_a? Array
        cause_info.collect { |cause| WsCee::CauseInfo.new cause }
      else
        [WsCee::CauseInfo.new(cause_info)]
      end
    end

    def detail(cause_code)
      response = @savon.call :detail, message: detail_query(cause_code)
      parse_detail_response response.hash
    end

    def parse_detail_response(hash)
      result = hash[:envelope][:body][:detail_result]
      return [] if result.nil?

      CauseDetail.new result[:cause]
    end

    def company_query(company_details)
      { 'LoginData' => login_data, 'SearchQuery' => { 'CompanyQuery' => { 'RegistrationID' => company_details[:registration_number] } } }
    end

    def person_query(person_details)
      { 'LoginData' => login_data, 'SearchQuery' => { 'PersonQuery' =>
                                                        { 'Name' => person_details[:name], 'DateOfBirth' => person_details[:date_of_birth] } } }
    end

    def detail_query(cause_code)
      { 'LoginData' => login_data, 'CauseCode' => cause_code }
    end

    def login_data
      { 'UserName' => @username, 'Password' => @password }
    end
  end
end
