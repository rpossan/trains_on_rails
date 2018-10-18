class TrainsError < StandardError
  attr_accessor :msg

  MESSAGES = {
    default: 'Trains on rails default error!',
    route_not_found: 'NO SUCH ROUTE'
  }.freeze

  def initialize(msg = :default)
    @msg = msg.class == Symbol ? MESSAGES[msg] : msg
    raise super(@msg)
  end

  def self.get_message(msg)
    MESSAGES[msg]
  end
end
