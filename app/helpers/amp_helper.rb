# Helper methods to generate AMP-compliant HTML
module AmpHelper
  # Overrides ActionView::Helpers::AssetTagHelper.image_tag
  def image_tag(source, options={})
    options = options.symbolize_keys
    check_for_image_tag_errors(options)

    src = options[:src] = path_to_image(source)

    unless src =~ /^(?:cid|data):/ || src.blank?
      options[:alt] = options.fetch(:alt) { image_alt(src) }
    end

    image_url = Addressable::URI.parse(source)
    host = request.host
    host << "/" unless source.first == "/"
    source.prepend(host) unless image_url.host.present?
    source.prepend(request.scheme + "://") unless image_url.scheme.present?
    options[:width], options[:height] = FastImage.size(source)
    options[:layout] = "responsive"
    tag("amp-img", options)
  end

  # Overrides ActionView::Helpers::FormTagHelper#form_tag_with_body
  def form_tag_with_body(html_options, content)
    html_options["_target"] = "_top"
    output = form_tag_html(html_options)
    output << content
    output.safe_concat("</form>")
  end
end
