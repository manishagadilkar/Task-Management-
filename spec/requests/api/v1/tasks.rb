# frozen_string_literal: true

require 'rails_helper'

RSpec.describe Api::V1::TasksController, type: :controller do
  let!(:tasks) { create_list(:task, 10) }
  let(:task_id) { tasks.first.id }

  describe 'GET #index' do
    before { get :index }

    context 'without params' do
      it 'returns all tasks' do
        expect(JSON.parse(response.body)['tasks'].size).to eq(10)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with status param' do
      before { get :index, params: { status: 'done' } }

      it 'returns filtered tasks' do
        expect(JSON.parse(response.body)['tasks']).to all(include('status' => 'done'))
      end
    end
  end

  describe 'POST #create' do
    let(:valid_attributes) { { title: 'Learn Ruby', description: 'Study the basics of Ruby', status: 'todo' } }

    context 'when the request is valid' do
      before { post :create, params: { task: valid_attributes } }

      it 'creates a task' do
        expect(JSON.parse(response.body)['title']).to eq('Learn Ruby')
      end

      it 'returns status code 201' do
        expect(response).to have_http_status(201)
      end
    end

    context 'when the request is invalid' do
      before { post :create, params: { task: { title: nil } } }

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end
  end

  describe 'GET #show' do
    before { get :show, params: { id: task_id } }

    context 'when the record exists' do
      it 'returns the task' do
        expect(JSON.parse(response.body)['task']['id']).to eq(task_id)
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'when the record does not exist' do
      let(:task_id) { 100 }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'PUT #update' do
    let(:valid_attributes) { { title: 'Updated Title', description: 'Updated Description', status: 'in_progress' } }

    context 'when the record exists' do
      before { put :update, params: { id: task_id, task: valid_attributes } }

      it 'updates the task' do
        updated_task = Task.find_by(id: task_id)
        expect(updated_task.title).to eq('Updated Title')
        expect(updated_task.description).to eq('Updated Description')
        expect(updated_task.status).to eq('in_progress')
      end

      it 'returns the updated task' do
        expect(JSON.parse(response.body)['task']['title']).to eq(valid_attributes[:title])
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end

    context 'with invalid attributes' do
      before { put :update, params: { id: task_id, task: { title: nil } } }

      it 'does not update the task' do
        original_title = tasks.first.title
        updated_task = Task.find_by(id: task_id)

        expect(updated_task.title).to eq(original_title)
      end

      it 'returns a validation failure message' do
        parsed_body = JSON.parse(response.body)
        expect(parsed_body['title'][0]).to eq("can't be blank")
      end

      it 'returns status code 422' do
        expect(response).to have_http_status(422)
      end
    end

    context 'when the record does not exist' do
      before { put :update, params: { id: 0, task: valid_attributes } }

      it 'returns status code 404' do
        expect(response).to have_http_status(404)
      end
    end
  end

  describe 'DELETE #destroy' do
    before { delete :destroy, params: { id: task_id } }

    it 'returns status code 204' do
      expect(response).to have_http_status(204)
    end
  end

  describe 'PATCH #mark_done' do
    context 'when marking an existing task as done' do
      before { patch :mark_done, params: { id: task_id } }

      it 'updates the task status to done' do
        updated_task = Task.find(task_id)
        expect(updated_task.status).to eq('done')
      end

      it 'returns status code 200' do
        expect(response).to have_http_status(200)
      end
    end
  end
end
