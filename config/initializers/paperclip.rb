unless Rails.env.development?
  Paperclip::Attachment.default_options[:url] = ':s3_domain_url'
  Paperclip::Attachment.default_options[:path] = '/:class/:attachment/:id_partition/:style/:filename'
  AWS.config(
    region: 'eu-central-1',
    s3_signature_version: :v4
	)
end
