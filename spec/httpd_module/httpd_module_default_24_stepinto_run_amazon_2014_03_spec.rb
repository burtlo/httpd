require 'spec_helper'

describe 'httpd_module::default on amazon-2014.04' do
  let(:httpd_module_default_24_stepinto_run_amazon_2014_03) do
    ChefSpec::Runner.new(
      :step_into => 'httpd_module',
      :platform => 'amazon',
      :version => '2014.03'
      ) do |node|
      node.set['httpd']['version'] = '2.4'
    end.converge('httpd_module::default')
  end

  context 'when using default parameters' do
    it 'creates httpd_module[auth_basic]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to create_httpd_module('auth_basic')
    end

    it 'installs package[auth_basic create httpd24]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to install_package('auth_basic create httpd24').with(
        :package_name => 'httpd24'
        )
    end

    it 'create directory[auth_basic create /etc/httpd/conf.modules.d]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to create_directory('auth_basic create /etc/httpd/conf.modules.d').with(
        :owner => 'root',
        :group => 'root',
        :recursive => true
        )
    end

    it 'create template[auth_basic create /etc/httpd/conf.modules.d/auth_basic.load]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to create_template('auth_basic create /etc/httpd/conf.modules.d/auth_basic.load').with(
        :owner => 'root',
        :group => 'root',
        :source => 'module_load.erb',
        :mode => '0644'
        )
    end

    it 'creates httpd_module[auth_kerb]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to create_httpd_module('auth_kerb')
    end

    it 'installs package[auth_kerb create mod24_auth_kerb]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to install_package('auth_kerb create mod24_auth_kerb').with(
        :package_name => 'mod24_auth_kerb'
        )
    end

    it 'create directory[auth_kerb create /etc/httpd/conf.modules.d]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to create_directory('auth_kerb create /etc/httpd/conf.modules.d').with(
        :owner => 'root',
        :group => 'root',
        :recursive => true
        )
    end

    it 'create template[auth_kerb create /etc/httpd/conf.modules.d/auth_kerb.load]' do
      expect(httpd_module_default_24_stepinto_run_amazon_2014_03).to create_template('auth_kerb create /etc/httpd/conf.modules.d/auth_kerb.load').with(
        :owner => 'root',
        :group => 'root',
        :source => 'module_load.erb',
        :mode => '0644'
        )
    end
  end
end
