# module ImageAttachable
# 	extend ActiveSupport::Concern

#   included do
#     column_names = []
#     column_names << :teaser_image
#     column_names << :teaser_image_en
#     column_names.each do |column_name|
#       has_attached_file column_name, :styles => { :medium => "430x304", :thumb => "100x100>" }, :convert_options => { :medium => "-quality 90", :thumb => "-quality 90"},
#         :storage => :s3,
#         :path => "articles/:attachment/:id/:style.:extension",
#         :s3_credentials => "#{Rails.root}/config/aws.yml"
#     end
#   end
# end