class Recipe < ApplicationRecord
    has_attached_file :recipe_image, styles: { thumb: 'x200' }
    validates_attachment_content_type :recipe_image, content_type: /\Aimage/

    validates :title, :cook_time, :cook_method, :ingredients, :recipe_type, :cuisine, :recipe_image, :difficulty, presence: true

    belongs_to :recipe_type
    belongs_to :cuisine
end
