require_relative '../../libraries/module_details_rhel.rb'
require_relative '../../libraries/module_details_dsl.rb'

describe 'looking up module package name' do
  before do
    extend Httpd::Module::Helpers::ModuleDetailsDSL
  end

  context 'for apache 2.2 on rhel-5' do
    # auth_kerb for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_auth_kerb', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/auth_kerb.conf'])
    end

    # auth_mysql for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_auth_mysql', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/auth_mysql.conf'])
    end

    # auth_psql for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_auth_psql', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/auth_psql.conf'])
    end

    # authz_ldap for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_authz_ldap', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/authz_ldap.conf'])
    end

    # dav_svn for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_dav_svn', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/subversion.conf'])
    end

    # nss for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_nss', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/nss.conf'])
    end

    # perl for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_perl', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/perl.conf'])
    end

    # python for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_python', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/python.conf'])
    end

    # revocator for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_revocator', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/revocator.conf'])
    end

    # ssl for 2.2 on rhel-5
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_ssl', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '5')
        ).to eq(['/etc/httpd/conf.d/ssl.conf'])
    end
  end

  context 'for apache 2.2 on rhel-6' do
    # auth_kerb for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_auth_kerb', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/auth_kerb.conf'])
    end

    # auth_mysql for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_auth_mysql', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/auth_mysql.conf'])
    end

    # authz_ldap for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_authz_ldap', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/authz_ldap.conf'])
    end

    # dav_svn for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_dav_svn', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/subversion.conf'])
    end

    # dnssd for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_dnssd', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/mod_dnssd.conf'])
    end

    # nss for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_nss', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/nss.conf'])
    end

    # perl for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_perl', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/perl.conf'])
    end

    # revocator for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_revocator', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/revocator.conf'])
    end

    # wsgi for 2.2 on rhel-6
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_wsgi', :httpd_version => '2.2', :platform => 'centos', :platform_family => 'rhel', :platform_version => '6')
        ).to eq(['/etc/httpd/conf.d/wsgi.conf'])
    end
  end

  context 'for apache 2.4 on rhel-7' do
    # auth_kerb for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_auth_kerb', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.modules.d/10-auth_kerb.conf'])
    end

    # dav_svn for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_dav_svn', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.modules.d/10-subversion.conf'])
    end

    # fcgid for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_fcgid', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.d/fcgid.conf', '/etc/httpd/conf.modules.d/10-fcgid.conf'])
    end

    # ldap for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_ldap', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.modules.d/01-ldap.conf'])
    end

    # nss for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_nss', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.d/nss.conf', '/etc/httpd/conf.modules.d/10-nss.conf'])
    end

    # proxy_html for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_proxy_html', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.modules.d/00-proxyhtml.conf'])
    end

    # revocator for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_revocator', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.d/revocator.conf', '/etc/httpd/conf.modules.d/11-revocator.conf'])
    end

    # security for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_security', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.d/mod_security.conf', '/etc/httpd/conf.modules.d/10-mod_security.conf'])
    end

    # session for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_session', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.modules.d/01-session.conf'])
    end

    # ssl for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_ssl', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.d/ssl.conf', '/etc/httpd/conf.modules.d/00-ssl.conf'])
    end

    # wsgi for 2.4 on rhel-7
    it 'returns the proper list of files to delete' do
      expect(
        find_deletes(:package => 'mod_wsgi', :httpd_version => '2.4', :platform => 'centos', :platform_family => 'rhel', :platform_version => '7')
        ).to eq(['/etc/httpd/conf.modules.d/10-wsgi.conf'])
    end
  end
end
