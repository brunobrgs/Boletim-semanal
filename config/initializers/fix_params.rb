module ActionController
  class Request
    private

      # Convert nested Hashs to HashWithIndifferentAccess and replace
      # file upload hashs with UploadedFile objects
      def normalize_parameters(value)
        case value
        when Hash
          if value.has_key?(:tempfile)
            upload = value[:tempfile]
            upload.extend(UploadedFile)
            upload.original_path = value[:filename]
            upload.content_type = value[:type]
            upload
          else
            h = {}
            value.each { |k, v| h[k] = normalize_parameters(v) }
            h.with_indifferent_access
          end
        when Array
          value.map { |e| normalize_parameters(e) }
        else
          value.force_encoding('utf-8') if '1.9'.respond_to?(:force_encoding) and !value.blank?
          value
        end
      end
  end
end

