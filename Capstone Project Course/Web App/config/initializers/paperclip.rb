Paperclip.options[:content_type_mappings] = {
    m4a: %w(audio/mp4)
}
if Rails.env.staging?
  Paperclip::Attachment.default_options[:url] = ":s3_domain_url"
  Paperclip::Attachment.default_options[:path] = "/:class/:attachment/:id_partition/:style/:filename"
end

if Rails.env.production?
  Paperclip::Attachment.default_options[:url] = ":s3_alias_url"
  Paperclip::Attachment.default_options[:s3_host_alias] = "d1kthnqllbvoat.cloudfront.net"
  Paperclip::Attachment.default_options[:path] = "/:class/:attachment/:id_partition/:style/:filename"
end
