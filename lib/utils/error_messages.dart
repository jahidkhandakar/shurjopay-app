class ErrorMessages {
  static String fromSpCode(String? code) {
    switch (code) {
      case "401":
        return "Incorrect mobile number or PIN.";
      case "403":
        return "Account is inactive. Please contact support";
      case "404":
        return "Resource not found.";
      case "409":
        return "This account already exists.";
      case "500":
        return "Server error. Please try again.";
      default:
        return "An unknown error occurred. Please try again.";
    }
  }
}
