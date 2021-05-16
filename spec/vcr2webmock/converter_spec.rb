# frozen_string_literal: true

RSpec.describe Vcr2webmock::Converter do
  subject(:converter_instance) do
    described_class.new(path_to_file)
  end

  describe '#convert' do
    context 'when parsed `cassette1.yml`' do
      let(:path_to_file) do
        Pathname.new('spec/dummy/cassette1.yml')
      end

      it 'outputs correct data' do
        expect{ converter_instance.convert }
          .to output(
            <<~TEXT
              # spec/dummy/cassette1.yml
              stub(:post, 'https://api.linkedin.com/v2/shares')
                .with(
                  headers: {"Authorization"=>"Bearer <LINKEDIN_TOKEN>", "Content-Type"=>"application/json"},
                  body: '{"owner":"urn:li:organization:<LINKEDIN_NETWORK_ID>","text":{"text":"test text"},"distribution":{"linkedInDistributionTarget":{"visibleToGuest":true}},"content":{"contentEntities":[{"entity":"<MEDIA_URN>"}]}}'
                )
                .to_return(
                  body: '{"owner":"urn:li:organization:<LINKEDIN_NETWORK_ID>","activity":"urn:li:activity:6395929324385550336","edited":false,"created":{"actor":"urn:li:person:-iTIL-CVQB","time":1524908381440},"serviceProvider":"API","id":"6395929323903213568","lastModified":{"actor":"urn:li:person:ZDPOCE6Wfp","time":1524908381531},"text":{"text":"test text"},"distribution":{"linkedInDistributionTarget":{"visibleToGuest":true}},"content":{"contentEntities":[{"entityLocation":"https://image-store.slidesharecdn.com/cd3e2c03-ed66-495c-b98a-85bff104042b-large.png","thumbnails":[{"resolvedUrl":"https://image-store.slidesharecdn.com/cd3e2c03-ed66-495c-b98a-85bff104042b-large.png"}],"entity":"<MEDIA_URN>"}],"shareMediaCategory":"RICH"}}'
                )
            TEXT
          ).to_stdout
      end
    end
  end
end
