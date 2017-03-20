Application.register 'rom' do
  @rom ||= begin
           configuration = ROM::Configuration.new(:sql, 'sqlite:memory')

           configuration.default.create_table(:modes) do
             primary_key :id

             column :name, String, null: false
             column :url, String, null: false
           end

           configuration.relation(:modes)

           ROM.container configuration
         end
end
