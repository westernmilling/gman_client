require 'gman_client/version'
require 'blanket'

# GmanClient
module GmanClient
  def self.drivers
    request = Blanket.wrap("http://localhost:3000", :extension => :json)
    respond = request.api.v1.drivers.get
    respond.map(&:to_h)
  end
  def self.driver_commission_histories
    request = Blanket.wrap("http://localhost:3000", :extension => :json)
    respond = request.api.v1.driver_commissions_history.get
    respond.map(&:to_h)
  end
  def self.driver_commission_histories_by_paid_date(paid_date)
    request = Blanket.wrap("http://localhost:3000", :extension => :json)
    respond = request.api.v1.driver_commissions_history_by_paid_date.get(params: {:paid_date => paid_date})
    respond.map(&:to_h)
  end
end
