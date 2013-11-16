class Mission < ActiveRecord::Base
  has_attached_file :source_code

  validates_attachment :source_code,  :presence     => true,
                                      :content_type => { :content_type => "text/xml" }
end
