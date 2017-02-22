class RegularCertificate < ApplicationRecord
    has_attached_file :ca
    has_attached_file :key
    has_attached_file :public
    do_not_validate_attachment_file_type :ca
    do_not_validate_attachment_file_type :key
    do_not_validate_attachment_file_type :public
end
