class Category < ApplicationRecord
#acts_as_nested_set
  has_many :products, dependent: :destroy
  has_many :sub_categories, class_name: Category.name,
  foreign_key: "parent_id", dependent: :destroy
   belongs_to :parent, class_name: Category.name, optional: true
   validates :name, presence: true, uniqueness: {case_sensitive: false}

  scope :get_root_categories,->{where parent_id: 0}

  scope :get_category_not_parent, -> do
    parent_ids = Category.group("parent_id").map(&:parent_id)
    Category.where.not(id: parent_ids)
  end

  scope :get_parent_category, -> parent_id do
    category = Category.find_by id: parent_id
    if category.present?
      parent_ids = Category.where(parent_id: category.parent_id)
      Category.where(id: parent_ids)
    end
  end

  def self.get_child_category id
    category = Category.find_by id: id
    ids = []
    if !category.nil?
      if category.sub_categories.present?
        category.sub_categories.each do |cat|
          ids += get_child_category(cat.id)
        end
      else
        ids << category.id
      end
    end
    ids
  end

end
