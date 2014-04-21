class Glasses < ActiveRecord::Base
  attr_accessible :glasses_name, :description, :price, :image, :manufacturer_id

  belongs_to :manufacturer

  #PaperClip
  has_attached_file :image, 
	:path => ":rails_root/public/system/:attachment/:id/:basename_:style.:extension",
	:url => "/system/:attachment/:id/:basename_:style.:extension",
	:styles => {
		:thumb    => ['120>'],
		:large  => ['550>'],
	},
	:convert_options => {
		:thumb    => '-set colorspace sRGB -strip',
		:large    => '-set colorspace sRGB -strip',
	}

  validates_presence_of :glasses_name
  validates_numericality_of :price
  validates_presence_of :manufacturer
  validates_attachment :image,
		:size => { :in => 0..10.megabytes },
		:content_type => { :content_type => /^image\/(jpeg|png|gif|tiff)$/ }

  def name
    "#{glasses_name}"
  end
  
  def self.latest(num)
    find :all, :limit => num, :order => "glasses.id desc", :include => [ :manufacturer ]
  end
end
