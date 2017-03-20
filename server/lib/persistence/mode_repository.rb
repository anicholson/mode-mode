Application.register 'modes_repository' do
  rom = Application['rom']
  Class.new(ROM::Repository[:modes]) do
    commands :create

    def count
      modes.count
    end

    def all
      modes.to_a
    end

    def query(conditions)
      modes.where(conditions)
    end

    def names
      modes.each.map(&:name)
    end
  end.new(rom)
end
