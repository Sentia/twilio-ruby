require 'spec_helper'

describe Twilio::TwiML::MessagingResponse do
  context 'Testing Response' do
    it 'should allow empty response' do
      r = Twilio::TwiML::MessagingResponse.new
      expect(r.to_s).to eq('<?xml version="1.0" encoding="UTF-8"?><Response/>')
    end

    it 'should allow populated response' do
      r = Twilio::TwiML::MessagingResponse.new
      r.message 'Hello'
      r.redirect('example.com')

      expect(r.to_s).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Message>Hello</Message><Redirect>example.com</Redirect></Response>')
    end

    it 'should allow chaining' do
      r = Twilio::TwiML::MessagingResponse.new.message('Hello').redirect('example.com')

      expect(r.to_s).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Message>Hello</Message><Redirect>example.com</Redirect></Response>')
    end
  end

  context 'Testing Message' do
    it 'should allow a body' do
      r = Twilio::TwiML::MessagingResponse.new
      r.message 'Hello'

      expect(r.to_s).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Message>Hello</Message></Response>')
    end

    it 'should allow appending Body' do
      b = Twilio::TwiML::Body.new('Hello World')

      r = Twilio::TwiML::MessagingResponse.new
      r.append(b)

      expect(r.to_s).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Body>Hello World</Body></Response>')
    end

    it 'should allow appending Body and Media' do
      b = Twilio::TwiML::Body.new('Hello World')
      m = Twilio::TwiML::Media.new('hey.jpg')

      r = Twilio::TwiML::MessagingResponse.new
      r.append(b)
      r.append(m)

      expect(r.to_s).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Body>Hello World</Body><Media>hey.jpg</Media></Response>')
    end
  end

  context 'Testing Redirect' do
    it 'should allow MessagingResponse.redirect' do
      r = Twilio::TwiML::MessagingResponse.new
      r.redirect('example.com')

      expect(r.to_s).to eq('<?xml version="1.0" encoding="UTF-8"?><Response><Redirect>example.com</Redirect></Response>')
    end
  end
end
