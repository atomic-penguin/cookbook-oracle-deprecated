require 'minitest/spec'

describe_recipe 'oracle' do

  include MiniTest::Chef::Assertions
  include MiniTest::Chef::Context
  include MiniTest::Chef::Resources

  describe "users and groups" do

    it "creates oracle user" do
      user('oracle').must_exist
    end
  
    it "creates oracle home directory" do
      directory('/home/oracle').must_exist
    end
  
    it "creates the necessary groups" do
      group("dba").must_exist
    end
  
    # Check for group membership, you can pass a single user or an array of
    # users:
    it "grants group membership to the expected users" do
      group("dba").must_include('oracle')
    end

  end

  describe "files and directories" do
    
    it 'creates limits.d oracle.conf file' do
      file("/etc/security/limits.d/oracle.conf").must_exist
    end
    
    it 'creates profile.d hostname file' do
      file("/etc/profile.d/oracle-hostname.sh").must_exist
    end

    it 'creates hugepage_settings file' do
      file("/usr/local/bin/hugepage_settings").must_exist
    end

    it 'create oracle install directory' do
      directory("/u01/app/oracle").must_exist
    end

  end

end
