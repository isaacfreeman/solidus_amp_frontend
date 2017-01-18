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
    source.prepend(request.host) unless image_url.host.present?
    source.prepend(request.scheme + "://") unless image_url.scheme.present?
    options[:width], options[:height] = FastImage.size(source)
    options[:layout] = "responsive"
    tag("amp-img", options)
  end
end
