# Service Class to sanitize HTML inputs for templates and update mails
class SanitizationService
  def initialize(html)
    @html = html
  end

  # Sanitizes the user template input following the Sanitize gems relaxed config.
  # Only allows links with http, https and mailto protocols.
  # Also removes carriage returns and line feeds.
  # @return   sanitized user input
  def sanitize
    @html = Sanitize.fragment(@html, Sanitize::Config.merge(Sanitize::Config::RELAXED,
                                      protocols: { 'a' => { 'href' => %w('http', 'https', 'mailto') } }))
    @html.tr!('\n', ' ')
    @html.tr!('\r', ' ')
    @html
  end
end
