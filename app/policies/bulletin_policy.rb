class BulletinPolicy < ApplicationPolicy
  def show?
    record.published? || owner? || admin?
  end

  def create?
    user.present?
  end

  def update?
    owner?
  end

  def to_moderate?
    owner?
  end

  def archive?
    owner?
  end

  private

  def owner?
    user.present? && record.user_id == user.id
  end

  def admin?
    user.present? && user.admin?
  end
end
