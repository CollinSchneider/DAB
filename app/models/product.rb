class Product < ActiveRecord::Base

  validates_presence_of :slug
  validates :title,
    presence: true,
    :uniqueness => {:message => "A product already exists with this title!"}

  validates :video_status,
    :presence => {:message => "error -> Video placement can't be blank if you are providing a video!"}, if: Proc.new { |product| product.embedded_video != '' }

  validates :embedded_video,
    :presence => {:message => "error -> Cannot have a video placement without proving a YouTube URL!"}, if: Proc.new {|product| product.video_status != ''}

  def to_param
    slug
  end

  belongs_to :user
  has_many :product_items, :dependent => :destroy
  has_many :cart_items, through: :product_items, :dependent => :destroy
  has_many :order_items, through: :product_items, :dependent => :destroy

  has_attached_file :image, styles: { large: "600x600!", medium: "300x300!", thumb: "100x100!" }
  validates_attachment_content_type :image, content_type: /\Aimage\/.*\Z/

  has_attached_file :image_two, styles: { large: "600x600!", medium: "300x300!", thumb: "100x100#" }
  validates_attachment_content_type :image_two, content_type: /\Aimage\/.*\Z/

  has_attached_file :image_three, styles: { large: "600x600!", medium: "300x300!", thumb: "100x100#" }
  validates_attachment_content_type :image_three, content_type: /\Aimage\/.*\Z/

  has_attached_file :image_four, styles: { large: "600x600!", medium: "300x300!", thumb: "100x100#" }
  validates_attachment_content_type :image_four, content_type: /\Aimage\/.*\Z/

  has_attached_file :image_five, styles: { large: "600x600!", medium: "300x300!", thumb: "100x100#" }
  validates_attachment_content_type :image_five, content_type: /\Aimage\/.*\Z/

  is_impressionable
end
