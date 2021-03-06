require_relative '../../libraries/module_package_info.rb'

describe 'looking up module package name' do
  before do
    extend Httpd::Module::Helpers
  end

  it 'returns nil when looking up an invalid package' do
    expect(
      package_name_for_module('asdasd', '2.2', 'debian', 'debian', '7.2')
      ).to eq(nil)
  end

  it 'returns nil when looking up an invalid version' do
    expect(
      package_name_for_module('asdasd', '2.4', 'debian', 'debian', '7.2')
      ).to eq(nil)
  end
end
