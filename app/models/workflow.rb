class Workflow < ApplicationRecord
    has_many :workflow_runs
    before_validation :generate_trigger_path
    validates :name, presence: true
    validates :trigger_path, presence: true, uniqueness: true
    validates :defination_jason, presence: true
              
    def generate_trigger_path
        self.trigger_path = SecureRandom.hex(16)
    end
end
