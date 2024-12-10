class Client < ApplicationRecord
  validates :dni,
            presence: { message: "El DNI no puede estar en blanco" },
            uniqueness: { message: "Ya existe un cliente con ese DNI" }
  validates :email,
            presence: { message: "El correo electrónico no puede estar en blanco" },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "Formato de correo electrónico inválido"
            },
            if: :email_modified?
  validates :first_name, presence: true
  validates :last_name, presence: true
  validates :birth_date, presence: true
  validate :birth_date_validity

  has_many :sales

  def email_modified?
    email_changed? && email_was != email
  end

  def birth_date_validity
    if birth_date.present?
      if birth_date < 120.years.ago
        errors.add(:birth_date, "Fecha de nacimiento inválida")
      elsif birth_date > 18.years.ago
        errors.add(:birth_date, "Debe ser mayor de edad")
      end
    end
  end
end
