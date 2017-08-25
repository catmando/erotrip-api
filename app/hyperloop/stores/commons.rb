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

  def self.cities
    [
      {label: 'Łódź', value: 'Łódź'},
      {label: 'Warszawa', value: 'warszawa'}
    ]
  end

  def self.photo_version element, version
    JSON.parse(element.gsub('=>', ':').gsub('nil', 'null'))[version]['url']
  end

end