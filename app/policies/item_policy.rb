class ItemPolicy < ApplicationPolicy
    def index?
      true
    end
   
    def create?
      user.admin?
    end
   
    def update?
      return true if user.present? && user == item.user
    end
   
    def destroy?
      return true if user.present? && user == item.user
    end
   
    private
   
      def item
        record
      end
end