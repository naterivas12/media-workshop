class ArticlePolicy < ApplicationPolicy
  class Scope < Scope
    def resolve
      # if !user
      #   scope.first(2)
      # elsif user.contributor?
      #   scope.first(3)
      # elsif user.admin?
      scope.all
      # end
    end
  end
end
