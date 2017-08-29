class Commons < Hyperloop::Store

  def self.account_kinds
    [
      {label: 'Kobieta', value: 'woman'},
      {label: 'Mężczyzna', value: 'man'},
      {label: 'Para hetero', value: 'couple'},
      {label: 'Para kobiet', value: 'women_couple'},
      {label: 'Para mężczyzn', value: 'men_couple'},
      {label: 'TGSV', value: 'tgsv'}
    ]
  end

  def self.photo_version element, version
    if element.present? && element.is_a?(String)
      proper_element = JSON.parse(element.gsub('=>', ':').gsub('nil', 'null'))
      if proper_element
        puts proper_element[version]['url']
        return proper_element[version]['url']
      end
    elsif element.present? && element.is_a?(Hash)
      return element[version]['url']
    end
  end

end