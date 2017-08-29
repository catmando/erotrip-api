# name: string
# desc: text
# photo: string
# kinds: string[]

# timestamps

class Group < ApplicationRecord
  KINDS = %w( man woman couple men_couple women_couple tgsv )

  scope :for_kinds, -> (*attrs) { where('ARRAY[groups.kinds]::varchar[] && ARRAY[?]::varchar[]', attrs) }

  validates :name, :desc, presence: true

  attr_accessor :photo_data

  def kinds=(new_val)
    if new_val.is_a? String
      if new_val.include?('|')
        new_val = new_val.split('|')
      elsif new_val.include?('[')
        new_val = JSON.parse(new_val)
      else
        new_val = [new_val]
      end
    end
    super(new_val)
  end

  # def kinds
  #   # read_attribute(:kinds).join('|')
  #   'man'
  # end

  # def kinds=(new_val)
  #   puts 'setting kinds'
  # end

  server_method :photo_url, default: '/assets/girl.jpg' do
    photo.try(:rect_160).try(:url)
  end


  # server_method "photo_url=", default: '/assets/girl.jpg' do |new_val|
  #   true
  # end

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

    def photo
      nil
    end

    # def kinds
    #   this_kinds = read_attribute(:kinds)
    #   if this_kinds.is_a? String
    #     this_kinds.split('|')
    #   else
    #     this_kinds
    #   end
    # end

  end

  protected

    def self.ransackable_scopes(auth_object = nil)
      [:for_kinds]
    end

end