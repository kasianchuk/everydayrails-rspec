require 'rails_helper'

RSpec.describe Project, type: :model do
  it 'does not allow duplicate project names per user' do
    user = User.create(
      first_name: 'Pavlo',
      last_name: 'Kasianchuk',
      email: 'kpm@gmail.com',
      password:'tri-li-liA',
    )

    user.projects.create(
      name: 'Test Project',
    )

    new_project = user.projects.build(
      name: 'Test Project',
    )

    new_project.valid?
    expect(new_project.errors[:name]).to include ('has already been taken')
  end

  it 'allows two users to share a project name' do
    user = User.create(
      first_name: 'Pavlo',
      last_name: 'Kasianchuk',
      email: 'kpm@gmail.com',
      password:'tri-li-liA',
    )

    user.projects.create(
      name: 'Test',
    )

    other_user = User.create(
      first_name: 'Igor',
      last_name: 'Tester',
      email: 'igor@gmail.com',
      password:'tri-li-liA',
    )

    other_project = other_user.projects.build(
      name: 'Test',
    )

    expect(other_project).to be_valid
  end
end
