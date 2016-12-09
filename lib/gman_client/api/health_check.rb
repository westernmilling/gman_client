module GmanClient
  module Api
    # HealthCheck API
    module HealthCheck
      # Retrieve a health check
      def health_check
        response = request.api.v1.health_check.get

        unless response.to_h[:health_check] == 'Passed'
          raise 'Health check failed. Relativity may be down'
        end
        response.to_h[:health_check]
      end
    end
  end
end
