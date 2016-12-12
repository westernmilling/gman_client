module GmanClient
  module Api
    # HealthCheck API
    module HealthCheck
      # Retrieve a health check
      def health_check
        response = request.api.v1.health_check.get

        response.to_h[:health_check] == 'Passed'
      end
    end
  end
end
