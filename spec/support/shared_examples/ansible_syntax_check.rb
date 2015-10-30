shared_examples 'ansible syntax check' do |inventory, playbook|
  it 'has valid syntax' do
    script = File.expand_path('../../../scripts/syntax_check.sh', __dir__)

    syntax_check = system("#{script} #{inventory} #{playbook}")

    expect(syntax_check).to eq true
  end
end
