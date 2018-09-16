class HTTP::Server::Context
  DEBUG_COLOR = :green
  setter better_cookies : Lucky::CookieJar?
  setter better_session : Lucky::SessionCookie?
  setter flash : Lucky::FlashStore?

  getter debug_messages : Array(String) = [] of String
  property? hide_from_logs : Bool = false

  def better_cookies
    @better_cookies ||= Lucky::BetterCookies::Processors::Encryptor.read(
      from: request
    )
  end

  def better_session
    @better_session ||= begin
      cookie = better_cookies.get?(Lucky::SessionCookie.settings.key)
      Lucky::SessionCookie.new(cookie)
    end
  end

  def cookies
    @cookies ||= Lucky::Cookies::Store.build(request, Lucky::Server.settings.secret_key_base)
  end

  def session
    @session ||= Lucky::Session::Store.new(cookies).build
  end

  def flash
    @flash ||= Lucky::FlashStore.from_session(better_session)
  end

  def add_debug_message(message : String)
    {% if !flag?(:release) %}
      debug_messages << message
    {% end %}
  end
end
