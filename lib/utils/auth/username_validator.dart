class UsernameValidator {
  static String? validate(String? value) {
    if (value == null || value.isEmpty) {
      return "Email is required";
    }
    return null; // geçerli
  }
}
