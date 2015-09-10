require 'test_helper'

class ContactsControllerTest < ActionController::TestCase
  setup do
    @contact = contacts(:one)
  end

  test "should get index" do
    get :index
    assert_response :success
    assert_not_nil assigns(:contacts)
  end

  test "should get new" do
    get :new
    assert_response :success
  end

  test "should create contact" do
    assert_difference('Contact.count') do
      post :create, contact: { End_time: @contact.End_time, Estimated_Date: @contact.Estimated_Date, Start_Time: @contact.Start_Time, Type_Meeting: @contact.Type_Meeting, assistants: @contact.assistants, city: @contact.city, company: @contact.company, email: @contact.email, message: @contact.message, names: @contact.names, phone: @contact.phone, theme: @contact.theme }
    end

    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should show contact" do
    get :show, id: @contact
    assert_response :success
  end

  test "should get edit" do
    get :edit, id: @contact
    assert_response :success
  end

  test "should update contact" do
    patch :update, id: @contact, contact: { End_time: @contact.End_time, Estimated_Date: @contact.Estimated_Date, Start_Time: @contact.Start_Time, Type_Meeting: @contact.Type_Meeting, assistants: @contact.assistants, city: @contact.city, company: @contact.company, email: @contact.email, message: @contact.message, names: @contact.names, phone: @contact.phone, theme: @contact.theme }
    assert_redirected_to contact_path(assigns(:contact))
  end

  test "should destroy contact" do
    assert_difference('Contact.count', -1) do
      delete :destroy, id: @contact
    end

    assert_redirected_to contacts_path
  end
end
