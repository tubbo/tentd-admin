require 'tentd'
require 'tentd-admin/set_entity'

module TentD
  class Server < ::TentD
    def initialize app
      @app = app
    end

    def call env
      use SetEntity
      run TentD.new
    end
  end
end
