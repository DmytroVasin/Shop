require 'spec_helper'

describe Product do
  before :each do
    @some_var = 'abrakadabraasasdasdasdasdasd'
  end

  it 'should have som_var' do
    @some_var.should_not be_nil
  end

  it 'should have som_var' do
    @some_var.should_not be_blank
  end

  it 'should have som_var' do
    @some_var.should_not be_blank
  end

  it 'SOME TRY' do
    foo = 'asasd'
    foo.stub(:bar).and_return 1, 2, 3
    foo.bar
    foo.bar
    foo.bar
  end

  describe "Form" do
    let (:model) { double :model }
    let (:form) { Cart.new model }
 
    context "when submitted" do
      it "saves the model" do
        form.stub(:submit).and_return true
        model.should_receive(:save)
        form.submit
      end
    end
  end
end
