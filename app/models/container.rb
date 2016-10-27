class Container < ApplicationRecord
  belongs_to :folder, optional: true
  belongs_to :containable, polymorphic: true, dependent: :destroy
end
