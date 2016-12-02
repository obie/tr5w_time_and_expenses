describe BillingCode do
  let(:travel_code) { BillingCode.create(code: 'TRAVEL') }
  let(:dev_code) { BillingCode.create(code: 'DEV') }

  before do
    travel_code.related << dev_code
  end

  it "has a working related habtm association" do
    expect(travel_code.reload.related).to include(dev_code)
  end

  it "should have a bidirectional habtm association" do
    expect(travel_code.related).to include(dev_code)
    expect(dev_code.reload.related).to include(travel_code)
  end

  it "should clean up reciprocal relationship on removal" do
    travel_code.related.delete(dev_code)
    expect(travel_code.related).to_not include(dev_code)
    expect(dev_code.reload.related).to_not include(travel_code)
  end
end
