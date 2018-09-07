require 'rails_helper'

RSpec.describe "ProjectsApis", type: :request do
  it 'loads a project' do
    user = FactoryBot.create(:user)
    FactoryBot.create(:project, name: 'Sample project')
    FactoryBot.create(:project, name: 'Second Sample project', owner: user)

    get api_projects_path, params: {
      user_email: user.email,
      user_token: user.authentication_token
    }

    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json.length).to eq 1
    project_id = json[0]['id']

    get api_project_path(project_id), params: {
      user_email: user.email,
      user_token: user.authentication_token
    }

    expect(response).to have_http_status(:success)
    json = JSON.parse(response.body)
    expect(json['name']).to eq 'Second Sample project'
  end

  it 'creates a project' do
    user = FactoryBot.create(:user)

    project_attributes = FactoryBot.attributes_for(:project)

    expect {
      post api_projects_path, params: {
        user_email: user.email,
        user_token: user.authentication_token,
        project: project_attributes
      }
    }.to change(user.projects, :count).by(1)

    expect(response).to have_http_status(:success)
  end

  context 'as an authenticated user' do
    before do
      @user = FactoryBot.create(:user)
    end

    context 'with valid attributes' do
      it 'adds a project' do
        project_params = FactoryBot.attributes_for(:project)
        sign_in @user
        expect {
          post projects_path, params: { project: project_params }
        }.to change(@user.projects, :count).by(1)
      end
    end

    context 'with invalid attributes' do
      it 'does not add a prject' do
        project_params = FactoryBot.attributes_for(:project, :invalid)
        sign_in @user
        expect {
          post projects_path,params: { project: project_params }
        }.to_not change(@user.projects, :count)
      end
    end
  end
end
