# frozen_string_literal: true

class Spree::Content < ActiveRecord::Base
  attr_accessor :delete_attachment

  acts_as_list scope: :page

  belongs_to :page
  validates_associated :page
  validates_presence_of :title, :page

  has_attached_file :attachment,
                    styles:        proc { |clip| clip.instance.attachment_sizes },
                    default_style: :preview,
                    url:           '/spree/contents/:id/:style/:basename.:extension',
                    path:          ':rails_root/public/spree/contents/:id/:style/:basename.:extension'

  validates_attachment_content_type :attachment, content_type: ['image/jpg', 'image/jpeg', 'image/png', 'image/gif']

  cattr_reader :per_page
  @@per_page = 10

  scope :for, proc { |context| where(context: context) }

  before_update :delete_attachment!, if: :delete_attachment
  # before_update :reprocess_images_if_context_changed

  %i[link_text link body].each do |property|
    define_method "has_#{property}?" do
      has_value property
    end
  end

  def has_full_link?
    has_link? && has_link_text?
  end

  def has_image?
    has_value(:attachment_file_name) && attachment_file_name.match(/gif|jpg|png/i)
  end

  def hide_title?
    hide_title == true
  end

  def rendered_body
    body&.html_safe
  end

  def default_attachment_sizes
    { mini: '48x48>', medium: '427x287>' }
  end

  def attachment_sizes
    sizes = case context
            when 'slideshow'
              default_attachment_sizes.merge(slide: '955x476#')
            else
              default_attachment_sizes
            end
    sizes
  end

  def context=(value)
    write_attribute :context, value.to_s.parameterize
  end

  private

  def delete_attachment!
    del = delete_attachment.to_s
    self.attachment = nil if del == '1' || del == 'true'
    true
  end

  def reprocess_images_if_context_changed
    return unless context_changed? && attachment_file_name.present?
    attachment.reprocess!
  end

  def has_value(selector)
    v = send selector
    v && !v.to_s.blank?
  end
end
