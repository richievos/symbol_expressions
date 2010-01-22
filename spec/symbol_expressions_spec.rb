require 'lib/symbol_expressions'
describe "Symbol expressions" do
  it "should call a cascade of messages with plus" do
    [1.2,2.8,3.2,4.6,5.1].map(&:round + :even?).should == [false,false,false,false,false]
  end

  it "should only call if a reciever responds_to if a message is signified by -@" do
    [1.2,2,3.2,4,5].map(&-:even?).should == [nil,true,nil,true,false]
  end

  it "should allow passing the arguments of a message using Symbol#[]" do
    [1,2,3,4,5].map(&:+[5]).should == [6,7,8,9,10]
  end

end
