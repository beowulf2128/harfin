class ResultMgr
  attr_accessor :errors, :status
  def initialize
    @errors = []
  end

  def errors?
    @errors.present?
  end
end
