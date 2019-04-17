class TerraDBState < Inspec.resource(1)
  name 'terradb_state'

  def initialize(opts = {})
    opts = { name: opts } if opts.is_a?(String)
    @state_name = opts[:name]
    raise ArgumentError, 'name should not be empty' if @state_name.empty? || @state_name.nil?

    @client = inspec.backend.terradb
  end

  def to_s
    "TerraDB state #{@state_name}"
  end

  def exists?
    !@client.state(@state_name, @state_serial).nil?
  end

  def terraform_version
    raw = raw_content
    raw["terraform_version"]
  end

  def raw_content
    @client.state(@state_name, @state_serial)
  end
end
