class ErrorSerializer
  def self.format_error(message, status = 400)
    {
      errors: [
        {
          detail: message, 
          status: status.to_s
        }
      ]
    }
  end
end