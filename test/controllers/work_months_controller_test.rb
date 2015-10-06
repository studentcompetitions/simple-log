require 'test_helper'

class WorkMonthsControllerTest < ActionController::TestCase
  setup do
    @work_month = work_months(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:work_months)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create work_month" do
    assert_difference('WorkMonth.count') do
      post :create, work_month: {  }
    end

    assert_redirected_to work_month_path(assigns(:work_month))
  end

  test "should show work_month" do
    get :show, id: @work_month
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @work_month
    assert_response :success
  end

  test "should update work_month" do
    patch :update, id: @work_month, work_month: {  }
    assert_redirected_to work_month_path(assigns(:work_month))
  end

  test "should destroy work_month" do
    assert_difference('WorkMonth.count', -1) do
      delete :destroy, id: @work_month
    end

    assert_redirected_to work_months_path
  end
end
