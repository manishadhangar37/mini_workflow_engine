class WorkflowRun < ApplicationRecord
  belongs_to :workflow

  enum :status, {
    success: 0,
    skipped: 1,
    failed: 2

  }
end
