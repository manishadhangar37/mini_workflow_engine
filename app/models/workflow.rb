class Workflow < ApplicationRecord
    has_many :workflow_runs, dependent: :destroy
    before_validation :generate_trigger_path
    validates :name, presence: true, uniqueness: true
    validates :trigger_path, presence: true, uniqueness: true
    validates :defination_jason, presence: true

    def generate_trigger_path
        self.trigger_path = SecureRandom.hex(16)
    end
end
