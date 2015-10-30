require 'spec_helper'

describe 'Ubuntu 14.04 LTS', if: os[:family] == 'ubuntu' do
  context 'role: common' do
    it 'installed apt-show-versions' do
      expect(package('apt-show-versions')).to be_installed
    end

    it 'updated all packages' do
      cmd = command('sudo apt-show-versions -u')
      expect(cmd.exit_status).to eq 0
    end
  end

  context 'role: ANXS.postgres' do
    it 'installed postgresql-9.4' do
      expect(package('postgresql-9.4')).to be_installed
    end

    it 'created a user' do
      cmd = command("psql postgres -tAc \"SELECT 1 FROM pg_roles WHERE rolname='rails_1'\" -U postgres")
      expect(cmd.stdout.chomp).to eq "1"
    end

    it 'created a table' do
      cmd = command('psql rails_1 -c "" -U rails_1')
      expect(cmd.exit_status).to eq 0
    end

    context 'enabled extensions' do
      it 'includes hstore' do
        cmd = command("psql -t -A -c \"select count(*) from pg_extension where extname = 'hstore'\" -U rails_1")
        expect(cmd.stdout.chomp).to eq "1"
      end

      it 'includes uuid_ossp' do
        cmd = command("psql -t -A -c \"select count(*) from pg_extension where extname = 'uuid-ossp'\" -U rails_1")
        expect(cmd.stdout.chomp).to eq "1"
      end

      it 'includes citext' do
        cmd = command("psql -t -A -c \"select count(*) from pg_extension where extname = 'citext'\" -U rails_1")
        expect(cmd.stdout.chomp).to eq "1"
      end
    end

    it 'installed libpq-dev' do
      expect(package('libpq-dev')).to be_installed
    end

    it 'installed python-psycopg2' do
      expect(package('python-psycopg2')).to be_installed
    end

    context 'service' do
      it 'is enabled' do
        expect(service('postgresql')).to be_enabled
      end

      it 'is running' do
        expect(service('postgresql')).to be_running
      end
    end

    it 'is listening on port 5432' do
      expect(port(5432)).to be_listening
    end
  end

  context 'role: development_packages' do
    let(:packages) do
      %w[
          software-properties-common
          python-software-properties
          curl
          build-essential
          libpq-dev
          libssl-dev
          libreadline-dev
          zlib1g-dev
          libffi-dev
          libncurses5-dev
          libyaml-dev
          libxml2
          libxml2-dev
          libxslt1-dev
          libsqlite3-dev
          git
          autoconf
        ]
    end

    it 'installed development packages' do
      packages.each do |pkg|
        expect(package(pkg)).to be_installed
      end
    end
  end

  context 'role: mikechau.jemalloc' do
    it 'installed jemalloc' do
      expect(file('/usr/lib/libjemalloc.so')).to be_file
    end
  end

  context 'role: rvm_io.rvm1-ruby' do
    it 'installed rvm' do
      expect(file('/home/vagrant/.rvm/bin/rvm')).to be_file
    end

    it 'installed ruby-2.2.3' do
      expect(file('/home/vagrant/.rvm/rubies/ruby-2.2.3/bin/ruby')).to be_file
    end
  end

  context 'role: nginx' do
    it 'installed nginx-extras' do
      expect(package('nginx-extras')).to be_installed
    end

    context 'service' do
      it 'is enabled' do
        expect(service('nginx')).to be_enabled
      end

      it 'is running' do
        expect(service('nginx')).to be_running
      end
    end

    it 'is listening on port 80' do
      expect(port(80)).to be_listening
    end
  end
end
