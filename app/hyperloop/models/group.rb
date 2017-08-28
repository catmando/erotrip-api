# name: string
# desc: text
# photo: string
# kinds: string[]

# timestamps

class Group < ApplicationRecord
  KINDS = %w( man woman couple men_couple women_couple tgsv )

  scope :for_kinds, -> (*attrs) { where('groups.kinds && ARRAY[?]::varchar[]', attrs) }

  scope :ordered, -> (order_value) { order(order_value) }
  scope :with_limit, -> (limit_value) { limit(limit_value) }

  validates :kinds, :name, :desc, presence: true

  attr_accessor :photo_data

  def kinds=(new_val)
    puts "new_val: #{nev_val}"
    super(new_val)
  end

  unless RUBY_ENGINE == 'opal'

    mount_uploader :photo, PhotoUploader

    def photo_uri=(uri_str)
      if uri_str.present? && uri_str.match(%r{^data:(.*?);(.*?),(.*);(.*?)$})
        uri = {}
        uri[:type] = $1
        uri[:encoder] = $2
        uri[:data] = $3
        uri[:extension] = $4.present? ? $4.split('.').last : $1.split('/')[1]
        uri[:filename] = $4.parameterize(separator: '.') if $4

        tmp = Tempfile.new("temp-file-#{Time.now.to_i}")
        tmp.binmode
        tmp << Base64.decode64(uri[:data])
        tmp.rewind

        self.photo = ActionDispatch::Http::UploadedFile.new(
          filename: ("#{uri[:filename]}" || "#{Time.now.to_i}.#{uri[:extension]}"),
          type: uri[:type],
          tempfile: tmp
        )
      end
    end
  else
    attr_accessor :photo_uri
  end

  protected

    def self.ransackable_scopes(auth_object = nil)
      [:for_kinds]
    end

end