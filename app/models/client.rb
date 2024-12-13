class Client < ApplicationRecord
  validates :dni,
            presence: { message: "El DNI no puede estar en blanco" },
            uniqueness: { message: "Ya existe un cliente con ese DNI" },
            length: { is: 8, message: "El DNI debe tener 8 números" },
            numericality: { only_integer: true, message: "El DNI debe contener solo números" }
  validates :email,
            presence: { message: "El correo electrónico no puede estar en blanco" },
            format: {
              with: URI::MailTo::EMAIL_REGEXP,
              message: "Formato de correo electrónico inválido"
            },
            length: { maximum: 255, message: "El correo electrónico es demasiado largo" },
            if: :email_modified?
  validates :first_name,
            presence: true,
            length: { maximum: 50, message: "El nombre es demasiado largo" }
  validates :last_name,
            presence: true,
            length: { maximum: 50, message: "El apellido es demasiado largo" }
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
