shared_examples 'db::init' do

  describe package('mysql-community-server') do
    it { should be_installed }
  end

  describe service('mysqld') do
    it { should be_enabled   }
    it { should be_running   }
  end

  describe port(3306) do
    it { should be_listening }
  end

  describe file('/etc/my.cnf') do
    it { should be_file }
    it { should contain "server-id = #{property[:server_id]}" }
  end

  describe yumrepo('mysql56-community') do
    it { should exist }
    it { should be_enabled }
  end

end