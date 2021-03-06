require 'spec_helper'

describe 'httpd_module::default on ubuntu-12.04' do
  let(:httpd_module_default_22_stepinto_run_ubuntu_12_04) do
    ChefSpec::Runner.new(
      :step_into => 'httpd_module',
      :platform => 'ubuntu',
      :version => '12.04'
      ) do |node|
      node.set['httpd']['version'] = '2.2'
    end.converge('httpd_module::default')
  end

  context 'when using default parameters' do
    it 'creates httpd_module[auth_basic]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_httpd_module('auth_basic')
    end

    it 'installs package[auth_basic create apache2]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to install_package('auth_basic create apache2').with(
        :package_name => 'apache2'
        )
    end

    it 'does not run bash[auth_basic create remove_package_config]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to_not run_bash('auth_basic create remove_package_config')
    end

    it 'creates directory[auth_basic create /etc/apache2/mods-available]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_directory('auth_basic create /etc/apache2/mods-available').with(
        :path => '/etc/apache2/mods-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :recursive => true
        )
    end

    it 'creates template[auth_basic create /etc/apache2/mods-available/auth_basic.load]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_template('auth_basic create /etc/apache2/mods-available/auth_basic.load').with(
        :path => '/etc/apache2/mods-available/auth_basic.load',
        :source => 'module_load.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'creates directory[auth_basic create /etc/apache2/mods-enabled]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_directory('auth_basic create /etc/apache2/mods-enabled').with(
        :path => '/etc/apache2/mods-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :recursive => true
        )
    end

    it 'creates link[auth_basic create /etc/apache2/mods-enabled]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_link('auth_basic create /etc/apache2/mods-enabled/auth_basic.load').with(
        :target_file => '/etc/apache2/mods-enabled/auth_basic.load',
        :to => '/etc/apache2/mods-available/auth_basic.load'
        )
    end

    it 'creates httpd_module[auth_kerb]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_httpd_module('auth_kerb')
    end

    it 'installs package[auth_kerb create libapache2-mod-auth-kerb]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to install_package('auth_kerb create libapache2-mod-auth-kerb').with(
        :package_name => 'libapache2-mod-auth-kerb'
        )
    end

    it 'does not run bash[auth_kerb create remove_package_config]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to_not run_bash('auth_kerb create remove_package_config')
    end

    it 'creates directory[auth_kerb create /etc/apache2/mods-available]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_directory('auth_kerb create /etc/apache2/mods-available').with(
        :path => '/etc/apache2/mods-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :recursive => true
        )
    end

    it 'creates template[auth_kerb create /etc/apache2/mods-available/auth_kerb.load]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_template('auth_kerb create /etc/apache2/mods-available/auth_kerb.load').with(
        :path => '/etc/apache2/mods-available/auth_kerb.load',
        :source => 'module_load.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'creates directory[auth_kerb create /etc/apache2/mods-enabled]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_directory('auth_kerb create /etc/apache2/mods-enabled').with(
        :path => '/etc/apache2/mods-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :recursive => true
        )
    end

    it 'creates link[auth_kerb create /etc/apache2/mods-enabled]' do
      expect(httpd_module_default_22_stepinto_run_ubuntu_12_04).to create_link('auth_kerb create /etc/apache2/mods-enabled/auth_kerb.load').with(
        :target_file => '/etc/apache2/mods-enabled/auth_kerb.load',
        :to => '/etc/apache2/mods-available/auth_kerb.load'
        )
    end
  end
end
