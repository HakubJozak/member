module MtgJsonLoader

  def self.load_all
    str = File.read(Rails.root + 'db/AllSets-x.json')
    sets = JSON.parse(str)
    sets.each_pair { |code,info| load_set(info) ; puts code }
  end

  # Pass either hash or filename.
  def self.load_set(arg)


    if arg.is_a?(Hash)
      arg['cards'].each do |attrs|
        attrs.delete 'foreignNames'
        attrs.delete 'printings'
        attrs.delete 'hand'
        attrs.delete 'life'
        attrs.delete 'border'
        attrs.delete 'watermark'

        attrs['card_type'] = attrs.delete('type')

        attrs.each_pair do |k,v|
          attrs[k] = v.to_s
        end


        Stamp.create!(attrs)
      end
    else
      file = File.new(arg)
      json = JSON.parse(file.read)
      ::MtgJsonLoader.load_set(json)
    end
  end

end
