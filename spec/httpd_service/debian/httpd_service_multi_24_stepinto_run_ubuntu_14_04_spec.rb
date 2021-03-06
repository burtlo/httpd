require 'spec_helper'

describe 'httpd_service::multi 2.4 on ubuntu-14.04' do
  let(:ubuntu_14_04_multi_stepinto_run) do
    ChefSpec::Runner.new(
      :step_into => 'httpd_service',
      :platform => 'ubuntu',
      :version => '14.04'
      ) do |node|
      node.set['httpd']['contact'] = 'bob@computers.biz'
      node.set['httpd']['version'] = '2.4'
      node.set['httpd']['keepalive'] = false
      node.set['httpd']['keepaliverequests'] = '5678'
      node.set['httpd']['keepalivetimeout'] = '8765'
      node.set['httpd']['listen_ports'] = %w(81 444)
      node.set['httpd']['log_level'] = 'warn'
      node.set['httpd']['run_user'] = 'bob'
      node.set['httpd']['run_group'] = 'bob'
      node.set['httpd']['timeout'] = '1434'
      node.set['httpd']['mpm'] = 'prefork'
    end.converge('httpd_service::multi')
  end

  before do
    stub_command('test -f /usr/sbin/a2enmod').and_return(true)
    stub_command('test -f /usr/sbin/a2enmod-instance-1').and_return(true)
    stub_command('test -f /usr/sbin/a2enmod-instance-2').and_return(true)
  end

  # top level recipe
  context 'when compiling the recipe' do

    it 'creates group alice' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_group('alice')
    end

    it 'creates user alice' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_user('alice').with(
        :gid => 'alice'
        )
    end

    it 'creates group bob' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_group('bob')
    end

    it 'creates user bob' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_user('bob').with(
        :gid => 'bob'
        )
    end

    it 'deletes httpd_service[default]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_httpd_service('default')
    end

    it 'creates httpd_service[instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_httpd_service('instance-1').with(
        :contact => 'hal@computers.biz',
        :hostname_lookups => 'off',
        :keepalive => false,
        :keepaliverequests => '2001',
        :keepalivetimeout => '0',
        :listen_addresses => ['0.0.0.0'],
        :listen_ports => %w(8080 4343),
        :log_level => 'warn',
        :version => '2.4',
        :package_name => 'apache2',
        :run_user => 'alice',
        :run_group => 'alice',
        :timeout => '4321'
        )
    end

    it 'creates httpd_service[instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_httpd_service('instance-2').with(
        :contact => 'bob@computers.biz',
        :hostname_lookups => 'off',
        :keepalive => false,
        :keepaliverequests => '5678',
        :keepalivetimeout => '8765',
        :listen_addresses => ['0.0.0.0'],
        :listen_ports => %w(81 444),
        :log_level => 'warn',
        :version => '2.4',
        :package_name => 'apache2',
        :run_user => 'bob',
        :run_group => 'bob',
        :timeout => '1434'
        )
    end
  end

  it 'writes log[notify restart]' do
    expect(ubuntu_14_04_multi_stepinto_run).to write_log('notify restart')
  end

  it 'writes log[notify reload]' do
    expect(ubuntu_14_04_multi_stepinto_run).to write_log('notify reload')
  end

  # step_into httpd_service[default]
  context 'when stepping into the httpd_service[default] resource' do

    it 'steps into httpd_service[default] and installs package[default delete apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to install_package('default delete apache2').with(
        :package_name => 'apache2'
        )
    end

    it 'disables service[default delete apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to disable_service('default delete apache2').with(
        :service_name => 'apache2',
        :provider => Chef::Provider::Service::Init::Debian
        )
      expect(ubuntu_14_04_multi_stepinto_run).to stop_service('default delete apache2').with(
        :service_name => 'apache2',
        :provider => Chef::Provider::Service::Init::Debian
        )
    end

    it 'does not run_bash[default delete remove_package_config]' do
      expect(ubuntu_14_04_multi_stepinto_run).to_not run_bash('default delete remove_package_config').with(
        :user => 'root'
        )
    end

    it 'deletes directory[default delete /var/cache/apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /var/cache/apache2').with(
        :path => '/var/cache/apache2',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /var/log/apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /var/log/apache2').with(
        :path => '/var/log/apache2',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /var/run/apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to_not delete_directory('default delete /var/run/apache2').with(
        :path => '/var/run/apache2',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /etc/apache2/conf-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /etc/apache2/conf-available').with(
        :path => '/etc/apache2/conf-available',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /etc/apache2/conf-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /etc/apache2/conf-enabled').with(
        :path => '/etc/apache2/conf-enabled',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /var/lock/apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /var/lock/apache2').with(
        :path => '/var/lock/apache2',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /etc/apache2/mods-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /etc/apache2/mods-available').with(
        :path => '/etc/apache2/mods-available',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /etc/apache2/mods-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /etc/apache2/mods-enabled').with(
        :path => '/etc/apache2/mods-enabled',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /etc/apache2/sites-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /etc/apache2/sites-available').with(
        :path => '/etc/apache2/sites-available',
        :recursive => true
        )
    end

    it 'deletes directory[default delete /etc/apache2/sites-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_directory('default delete /etc/apache2/sites-enabled').with(
        :path => '/etc/apache2/sites-enabled',
        :recursive => true
        )
    end

    it 'deletes file[default delete /usr/sbin/a2enmod]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_file('default delete /usr/sbin/a2enmod').with(
        :path => '/usr/sbin/a2enmod'
        )
    end

    it 'deletes link[default delete /usr/sbin/a2dismod]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_link('default delete /usr/sbin/a2dismod').with(
        :path => '/usr/sbin/a2dismod'
        )
    end

    it 'deletes link[default delete /usr/sbin/a2ensite]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_link('default delete /usr/sbin/a2ensite').with(
        :path => '/usr/sbin/a2ensite'
        )
    end

    it 'deletes link[default delete /usr/sbin/a2dissite]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_link('default delete /usr/sbin/a2dissite').with(
        :path => '/usr/sbin/a2dissite'
        )
    end

    it 'deletes file[default delete /etc/apache2/magic]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_file('default delete /etc/apache2/magic').with(
        :path => '/etc/apache2/magic'
        )
    end

    it 'deletes file[default delete /etc/apache2/ports.conf]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_file('default delete /etc/apache2/ports.conf').with(
        :path => '/etc/apache2/ports.conf'
        )
    end
  end

  # step_into httpd_service[instance-1]
  context 'when stepping into the httpd_service[instance-1] resource' do
    it 'steps into httpd_service[instance-1] and installs package[instance-1 create apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to install_package('instance-1 create apache2').with(
        :package_name => 'apache2'
        )
    end

    it 'does not run_bash[instance-1 delete remove_package_config]' do
      expect(ubuntu_14_04_multi_stepinto_run).to_not run_bash('instance-1 create remove_package_config').with(
        :user => 'root'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /var/cache/apache2-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /var/cache/apache2-instance-1').with(
        :path => '/var/cache/apache2-instance-1',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /var/log/apache2-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /var/log/apache2-instance-1').with(
        :path => '/var/log/apache2-instance-1',
        :owner => 'root',
        :group => 'adm',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /var/run/apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /var/run/apache2').with(
        :path => '/var/run/apache2',
        :owner => 'root',
        :group => 'adm',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /etc/apache2-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /etc/apache2-instance-1').with(
        :path => '/etc/apache2-instance-1',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /etc/apache2-instance-1/conf-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /etc/apache2-instance-1/conf-available').with(
        :path => '/etc/apache2-instance-1/conf-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /etc/apache2-instance-1/conf-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /etc/apache2-instance-1/conf-enabled').with(
        :path => '/etc/apache2-instance-1/conf-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /var/lock/apache2-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /var/lock/apache2-instance-1').with(
        :path => '/var/lock/apache2-instance-1',
        :owner => 'alice',
        :group => 'alice',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /etc/apache2-instance-1/mods-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /etc/apache2-instance-1/mods-available').with(
        :path => '/etc/apache2-instance-1/mods-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /etc/apache2-instance-1/mods-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /etc/apache2-instance-1/mods-enabled').with(
        :path => '/etc/apache2-instance-1/mods-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /etc/apache2-instance-1/sites-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /etc/apache2-instance-1/sites-available').with(
        :path => '/etc/apache2-instance-1/sites-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates directory[instance-1 create /etc/apache2-instance-1/sites-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-1 create /etc/apache2-instance-1/sites-enabled').with(
        :path => '/etc/apache2-instance-1/sites-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-1] and creates template[instance-1 create /etc/apache2-instance-1/envvars]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-1 create /etc/apache2-instance-1/envvars').with(
        :path => '/etc/apache2-instance-1/envvars',
        :source => 'envvars.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-1] and creates template[instance-1 create /usr/sbin/a2enmod]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-1 create /usr/sbin/a2enmod').with(
        :path => '/usr/sbin/a2enmod',
        :source => '2.4/scripts/a2enmod.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-1] and creates link[instance-1 create /usr/sbin/a2enmod-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to_not create_link('instance-1 create /usr/sbin/a2enmod-instance-1').with(
        :target_file => '/usr/sbin/a2enmod-instance-1',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-1] and creates link[instance-1 create /usr/sbin/a2dismod-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_link('instance-1 create /usr/sbin/a2dismod-instance-1').with(
        :target_file => '/usr/sbin/a2dismod-instance-1',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-1] and creates link[instance-1 create /usr/sbin/a2ensite-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_link('instance-1 create /usr/sbin/a2ensite-instance-1').with(
        :target_file => '/usr/sbin/a2ensite-instance-1',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-1] and creates link[instance-1 create /usr/sbin/a2dissite-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_link('instance-1 create /usr/sbin/a2dissite-instance-1').with(
        :target_file => '/usr/sbin/a2dissite-instance-1',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-1] and creates template[instance-1 create /etc/apache2-instance-1/magic]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-1 create /etc/apache2-instance-1/magic').with(
        :path => '/etc/apache2-instance-1/magic',
        :source => 'magic.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-1] and deletes file[instance-1 create /etc/apache2-instance-1/ports.conf]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_file('instance-1 create /etc/apache2-instance-1/ports.conf').with(
        :path => '/etc/apache2-instance-1/ports.conf'
        )
    end

    it 'steps into httpd_service[instance-1] and creates template[instance-1 create /etc/init.d/apache2-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-1 create /etc/init.d/apache2-instance-1').with(
        :path => '/etc/init.d/apache2-instance-1',
        :source => '2.4/sysvinit/ubuntu-14.04/apache2.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :cookbook => 'httpd'
        )
    end

    # begin mpm config section
    it 'steps into httpd_service[instance-1] and installs package[instance-1 create apache2-mpm-prefork]' do
      expect(ubuntu_14_04_multi_stepinto_run).to install_package('instance-1 create apache2-mpm-prefork').with(
        :package_name => 'apache2-mpm-prefork'
        )
    end

    it 'steps into httpd_service[instance-1] and creates httpd_module[instance-1 create mpm_prefork]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_httpd_module('instance-1 create mpm_prefork').with(
        :module_name => 'mpm_prefork',
        :instance => 'instance-1',
        :httpd_version => '2.4'
        )
    end

    it 'steps into httpd_service[instance-1] and creates httpd_config[instance-1 create mpm_prefork]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_httpd_config('instance-1 create mpm_prefork').with(
        :config_name => 'mpm_prefork',
        :instance => 'instance-1',
        :source => 'mpm.conf.erb',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-1] and deletes httpd_config[instance-1 create mpm_worker]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_httpd_config('instance-1 create mpm_worker').with(
        :config_name => 'mpm_worker',
        :instance => 'instance-1'
        )
    end

    it 'steps into httpd_service[instance-1] and deletes httpd_config[instance-1 create mpm_event]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_httpd_config('instance-1 create mpm_event').with(
        :config_name => 'mpm_event',
        :instance => 'instance-1'
        )
    end

    it 'steps into httpd_service[instance-1] and creates template[instance-1 create /etc/apache2-instance-1/apache2.conf]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-1 create /etc/apache2-instance-1/apache2.conf').with(
        :path => '/etc/apache2-instance-1/apache2.conf',
        :source => 'httpd.conf.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-2] and creates template[instance-2 create /usr/sbin/a2enmod]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-2 create /usr/sbin/a2enmod').with(
        :path => '/usr/sbin/a2enmod',
        :source => '2.4/scripts/a2enmod.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-1] and manages service[instance-1 create apache2-instance-1]' do
      expect(ubuntu_14_04_multi_stepinto_run).to start_service('instance-1 create apache2-instance-1').with(
        :service_name => 'apache2-instance-1',
        :provider => Chef::Provider::Service::Init::Debian
        )
      expect(ubuntu_14_04_multi_stepinto_run).to enable_service('instance-1 create apache2-instance-1').with(
        :service_name => 'apache2-instance-1',
        :provider => Chef::Provider::Service::Init::Debian
        )
    end
  end

  # step_into httpd_service[instance-2]
  context 'when stepping into the httpd_service[instance-2] resource' do
    it 'steps into httpd_service[instance-2] and installs package[instance-2 create apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to install_package('instance-2 create apache2').with(
        :package_name => 'apache2'
        )
    end

    it 'does not run_bash[instance-2 delete remove_package_config]' do
      expect(ubuntu_14_04_multi_stepinto_run).to_not run_bash('instance-2 create remove_package_config').with(
        :user => 'root'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /var/cache/apache2-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /var/cache/apache2-instance-2').with(
        :path => '/var/cache/apache2-instance-2',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /var/log/apache2-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /var/log/apache2-instance-2').with(
        :path => '/var/log/apache2-instance-2',
        :owner => 'root',
        :group => 'adm',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /var/run/apache2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /var/run/apache2').with(
        :path => '/var/run/apache2',
        :owner => 'root',
        :group => 'adm',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /etc/apache2-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /etc/apache2-instance-2').with(
        :path => '/etc/apache2-instance-2',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /etc/apache2-instance-2/conf-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /etc/apache2-instance-2/conf-available').with(
        :path => '/etc/apache2-instance-2/conf-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /etc/apache2-instance-2/conf-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /etc/apache2-instance-2/conf-enabled').with(
        :path => '/etc/apache2-instance-2/conf-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /var/lock/apache2-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /var/lock/apache2-instance-2').with(
        :path => '/var/lock/apache2-instance-2',
        :owner => 'bob',
        :group => 'bob',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /etc/apache2-instance-2/mods-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /etc/apache2-instance-2/mods-available').with(
        :path => '/etc/apache2-instance-2/mods-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /etc/apache2-instance-2/mods-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /etc/apache2-instance-2/mods-enabled').with(
        :path => '/etc/apache2-instance-2/mods-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /etc/apache2-instance-2/sites-available]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /etc/apache2-instance-2/sites-available').with(
        :path => '/etc/apache2-instance-2/sites-available',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates directory[instance-2 create /etc/apache2-instance-2/sites-enabled]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_directory('instance-2 create /etc/apache2-instance-2/sites-enabled').with(
        :path => '/etc/apache2-instance-2/sites-enabled',
        :owner => 'root',
        :group => 'root',
        :mode => '0755'
        )
    end

    it 'steps into httpd_service[instance-2] and creates template[instance-2 create /etc/apache2-instance-2/envvars]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-2 create /etc/apache2-instance-2/envvars').with(
        :path => '/etc/apache2-instance-2/envvars',
        :source => 'envvars.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-2] and creates link[instance-2 create /usr/sbin/a2enmod-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to_not create_link('instance-2 create /usr/sbin/a2enmod-instance-2').with(
        :target_file => '/usr/sbin/a2enmod-instance-2',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-2] and creates link[instance-2 create /usr/sbin/a2dismod-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_link('instance-2 create /usr/sbin/a2dismod-instance-2').with(
        :target_file => '/usr/sbin/a2dismod-instance-2',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-2] and creates link[instance-2 create /usr/sbin/a2ensite-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_link('instance-2 create /usr/sbin/a2ensite-instance-2').with(
        :target_file => '/usr/sbin/a2ensite-instance-2',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-2] and creates link[instance-2 create /usr/sbin/a2dissite-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_link('instance-2 create /usr/sbin/a2dissite-instance-2').with(
        :target_file => '/usr/sbin/a2dissite-instance-2',
        :to => '/usr/sbin/a2enmod',
        :owner => 'root',
        :group => 'root'
        )
    end

    it 'steps into httpd_service[instance-2] and creates template[instance-2 create /etc/apache2-instance-2/magic]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-2 create /etc/apache2-instance-2/magic').with(
        :path => '/etc/apache2-instance-2/magic',
        :source => 'magic.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-2] and deletes file[instance-2 create /etc/apache2-instance-2/ports.conf]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_file('instance-2 create /etc/apache2-instance-2/ports.conf').with(
        :path => '/etc/apache2-instance-2/ports.conf'
        )
    end

    it 'steps into httpd_service[instance-2] and creates template[instance-2 create /etc/init.d/apache2-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-2 create /etc/init.d/apache2-instance-2').with(
        :path => '/etc/init.d/apache2-instance-2',
        :source => '2.4/sysvinit/ubuntu-14.04/apache2.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0755',
        :cookbook => 'httpd'
        )
    end

    # begin mpm config section
    it 'steps into httpd_service[instance-2] and installs package[instance-2 create apache2-mpm-prefork]' do
      expect(ubuntu_14_04_multi_stepinto_run).to install_package('instance-2 create apache2-mpm-prefork').with(
        :package_name => 'apache2-mpm-prefork'
        )
    end

    it 'steps into httpd_service[instance-2] and creates httpd_module[instance-2 create mpm_prefork]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_httpd_module('instance-2 create mpm_prefork').with(
        :module_name => 'mpm_prefork',
        :instance => 'instance-2',
        :httpd_version => '2.4'
        )
    end

    it 'steps into httpd_service[instance-2] and creates httpd_config[instance-2 create mpm_prefork]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_httpd_config('instance-2 create mpm_prefork').with(
        :config_name => 'mpm_prefork',
        :instance => 'instance-2',
        :source => 'mpm.conf.erb',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-2] and deletes httpd_config[instance-2 create mpm_worker]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_httpd_config('instance-2 create mpm_worker').with(
        :config_name => 'mpm_worker',
        :instance => 'instance-2'
        )
    end

    it 'steps into httpd_service[instance-2] and deletes httpd_config[instance-2 create mpm_event]' do
      expect(ubuntu_14_04_multi_stepinto_run).to delete_httpd_config('instance-2 create mpm_event').with(
        :config_name => 'mpm_event',
        :instance => 'instance-2'
        )
    end

    it 'steps into httpd_service[instance-2] and creates template[instance-2 create /etc/apache2-instance-2/apache2.conf]' do
      expect(ubuntu_14_04_multi_stepinto_run).to create_template('instance-2 create /etc/apache2-instance-2/apache2.conf').with(
        :path => '/etc/apache2-instance-2/apache2.conf',
        :source => 'httpd.conf.erb',
        :owner => 'root',
        :group => 'root',
        :mode => '0644',
        :cookbook => 'httpd'
        )
    end

    it 'steps into httpd_service[instance-2] and manages service[instance-2 create apache2-instance-2]' do
      expect(ubuntu_14_04_multi_stepinto_run).to start_service('instance-2 create apache2-instance-2').with(
        :service_name => 'apache2-instance-2',
        :provider => Chef::Provider::Service::Init::Debian
        )
      expect(ubuntu_14_04_multi_stepinto_run).to enable_service('instance-2 create apache2-instance-2').with(
        :service_name => 'apache2-instance-2',
        :provider => Chef::Provider::Service::Init::Debian
        )
    end
  end
end
