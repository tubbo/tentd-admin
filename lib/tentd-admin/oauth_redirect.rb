module TentD
  class OAuthRedirect
    def initialize app
      @app = app
    end

    def call env
      status, headers, response = @app.call env
      auth_url = ((env['HTTP_X_FORWARDED_PROTO'] || env['rack.url_scheme']) + '://' + env['HTTP_HOST'])
      auth_url += '/admin/oauth/confirm'
      auth_url += "?#{env['QUERY_STRING']}"
      [status, headers.merge("Location" => auth_url), response]
    end
  end
end
