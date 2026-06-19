require './../../Ruby/Projects/ceasar_cipher.rb'



describe "#ceasar_cipher" do

  let(:text) {String.new('Jamal')}
  let(:key) {5}

  subject(:cipher) {ceasar_cipher( text, key )}
  

  context "when ceasar cipher is run" do
    it "returns a string" do
      expect(cipher).to be_an(String)
    end

    it "has the same length as input" do
      expect(cipher.length).to eq(text.length)
    end

    it "does not equal original text" do
      expect(cipher).not_to eq(text)
    end

  end

  context "when text is Jamal and key is 5" do
    it " returns Ofrfq" do
      expect(cipher).to eq('Ofrfq')
    end
  end
end