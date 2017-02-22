class RootCertificate < ApplicationRecord
    has_attached_file :ca
    has_attached_file :key
    do_not_validate_attachment_file_type :ca
    do_not_validate_attachment_file_type :key
end
