class Event < ActiveRecord::Base
  belongs_to :user
  belongs_to :venue
  belongs_to :category
  has_many :ticket_types
  validates_inclusion_of :status, in: ['Draft', 'Published', 'Expired', 'Archived']

  validates_presence_of :extended_html_description, :venue, :category, :starts_at
  validates_uniqueness_of :name, uniqueness: {scope: [:venue, :starts_at]}

  def self.upcoming
    where("starts_at > ? and status = 'Published'", DateTime.now)
  end 

  def future?
    starts_at > DateTime.now
  end

  def publish
    if self.ticket_types.count == 0
      errors.add(:ticket_types, "require at least one ticket type")
      return false
    end
    
    self.status = 'Published'
    save!
  end 

  def archive
    self.status = 'Archived'
    save!
  end 

  def draft?
    self.status == 'Draft'
  end

  def published?
    self.status == 'Published'
  end

  def archived?
    self.status == 'Archived'
  end

end
