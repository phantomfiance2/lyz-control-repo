# frozen_string_literal: true

require 'spec_helper'

describe 'pe_getstarted_app' do
  on_supported_os.each do |os, os_facts|
    context "on #{os}" do
      let(:facts) { os_facts }

      it { is_expected.to compile }
    end
  end

  describe 'standard content' do
    it { is_expected.to contain_class('apache').with('mpm_module' => 'prefork') }

    it {
      is_expected.to contain_apache__vhost('pe_getstarted_app').with(
        'port' => '80',
      )
    }

    it {
      is_expected.to contain_file('/var/www/pe_getstarted_app/index.php').with(
        'ensure'  => 'file',
        'content' => "<?php phpinfo() ?>\n",
        'mode' => '0644',
      )
    }
  end

  describe 'custom content' do
    let(:params) do
      { 'content' => "custom\n" }
    end

    it {
      is_expected.to contain_file('/var/www/pe_getstarted_app/index.php').with(
        'ensure'  => 'file',
        'content' => "custom\n",
        'mode' => '0644',
      )
    }
  end
end
