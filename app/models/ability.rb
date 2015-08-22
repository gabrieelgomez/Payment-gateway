class Ability
  include CanCan::Ability

  def initialize(user)
    user ||= User.new # guest user (not logged in)
    if user.has_role? :admin

      # - user authorize -
      can [:delete, :show, :edit, :update, :create, :index, :destroy_multiple], User
      can :destroy, User do |u| !u.eql?(user) end
      
    elsif user.has_role? :client

      # - user authorize -
      can :read, User      
    end

      if user.has_role? :admin
      can :manage, KepplerBlog::Post
      can :manage, KepplerBlog::Category
    elsif user.has_role? :autor
      can :manage, KepplerBlog::Post, :user_id => user.id
    elsif user.has_role? :editor
      can [:index, :update, :edit, :show]


    end 

    can [:index, :show], KepplerCatalogs::Catalog
    can [:index, :show], KepplerCatalogs::Category
    can :manage, KepplerCatalogs::Attachment 
  end
end
