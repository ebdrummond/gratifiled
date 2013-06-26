module ConfirmationHelper

  def formatted(expiration)
    local_time = expiration.to_time.localtime
    local_time.strftime("%B %-d at %-l:%M %P")
  end
end