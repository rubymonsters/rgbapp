require "application_system_test_case"

class AdminUsersTest < ApplicationSystemTestCase

  setup do
    create(:user, email: "admin@user.de", password: "admin", admin: true)
    @user = create(:user, email: "test@user.de", password: "test", admin: false)

    visit admin_users_path

    fill_in "Email", with: "admin@user.de"
    fill_in "Password", with: "admin"

    click_on "Sign in"
  end

  test "Giving and removing admin rights" do
    click_on "Make admin"

    assert @user.reload.admin?

    click_on "Remove rights"

    assert !@user.reload.admin?
  end

  test "Deleting user" do
    click_on "Delete user"

    assert_equal User.count, 1
  end
end
