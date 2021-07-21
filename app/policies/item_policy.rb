class ItemPolicy < ApplicationPolicy
    def index?
      true
    end
   
    def create?
      user.admin?
    end
   
    def update?
      user.admin?
      # return true if user.present? && user == item.user
    end
   
    def destroy?
      user.admin?
      # return true if user.present? && user == item.user
    end
   
    private
   
      def item
        record
      end
end