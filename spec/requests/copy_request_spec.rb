require 'rails_helper'

describe "Copies", type: :request do
  let(:params) {}
  let(:json_response) do
    JSON.parse(response.body, symbolize_names: true)
  end

  describe '#index' do
    subject { get '/copy', params: params }

    before { subject }


    context 'returns 2 records' do
      let(:params) do
        {
          since: 1604489778
        }
      end

      it 'succeed' do
        expect(response).to have_http_status(:success)
        expect(json_response.size).to eq(2)
      end
    end
  end

  describe '#show' do
    subject { get "/copy/#{id}", params: params }

    before { subject }

    context "returns {value: 'Hi John, welcome to Bridge!'}" do
      let(:id) { 'greeting' }
      let(:params) do
        {
          name: 'John',
          app: 'Bridge'
        }
      end

      it 'succeed' do
        expect(response).to have_http_status(:success)
        expect(json_response).to eq({
          value: 'Hello John, welcome to Bridge!'
        })
      end
    end

    context "returns {value: 'Intro created on Tue Oct 27 08:56:55PM'}" do
      let(:id) { 'intro.created_at' }
      let(:params) do
        {
          created_at: 1603803415
        }
      end

      it 'succeed' do
        expect(response).to have_http_status(:success)
        expect(json_response).to eq({
          value: 'Intro created on Tue Oct 27 08:56:55PM'
        })
      end
    end

    context "returns {value: 'Intro created on Tue Oct 27 3:56:55PM'}" do
      let(:id) { 'intro.updated_at' }
      let(:params) do
        {
          updated_at: 1603803415
        }
      end

      it 'succeed' do
        expect(response).to have_http_status(:success)
        expect(json_response).to eq({
          value: 'Intro updated on Tue Oct 27 08:56:55PM'
        })
      end
    end

    context "returns {value: 'It is Tue Nov 03 05:31:47AM'}" do
      let(:id) { 'time' }
      let(:params) do
        {
          time: 1604352707
        }
      end

      it 'succeed' do
        expect(response).to have_http_status(:success)
        expect(json_response).to eq({
          value: 'It is Tue Nov 03 05:31:47AM'
        })
      end
    end

    context "returns {value: 'Goodbye'}" do
      let(:id) { 'bye' }
      let(:params) { {} }

      it 'succeed' do
        expect(response).to have_http_status(:success)
        expect(json_response).to eq({
          value: 'Goodbye'
        })
      end
    end
  end

  describe '#refresh' do
    subject { get "/copy/bye" }

    before { subject }

    it 'succeed' do
      expect(response).to have_http_status(:success)
    end
  end
end
