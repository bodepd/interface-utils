require 'puppet/application/test'
describe Puppet::Application::Test do
  before :each do
    @app = Puppet::Application::Test.new
  end
  describe 'when rendering check_tests' do
    before :each do
      @app.verb='check_tests'
    end
    it 'should print that not tests are missing' do
      @app.render([]).should == 'No missing tests'
    end
    it 'should list missing tests' do
      @app.render(['foo/init.pp']).should ==
'The following tests need to be added
foo/tests/init.pp
'
    end
    it 'should list multiple missing tests' do
      @app.render(['foo/init.pp', 'foo/dev/foo.pp']).should ==
'The following tests need to be added
foo/tests/init.pp
foo/tests/dev/foo.pp
'
    end
    describe 'when compiling tests' do
    end
  end
end
