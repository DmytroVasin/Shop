require "spec_helper"

describe OrderNotifier do
  describe "received" do
    let(:mail) { OrderNotifier.received }

    it "renders the headers" do
      mail.subject.should eq("Received")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

  describe "shipped" do
    let(:mail) { OrderNotifier.shipped }

    it "renders the headers" do
      mail.subject.should eq("Shipped")
      mail.to.should eq(["to@example.org"])
      mail.from.should eq(["from@example.com"])
    end

    it "renders the body" do
      mail.body.encoded.should match("Hi")
    end
  end

end
