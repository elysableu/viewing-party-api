class ErrorSerializer
  def self.format_error(error_message, status_code)
    # binding.pry
    {
      message: error_message,
      status: status_code
    }
  end
end