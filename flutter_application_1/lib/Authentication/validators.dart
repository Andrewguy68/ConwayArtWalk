/// checks shared by the Login and Signup
/// each method returns an error message to show under the field, or null when
/// the value is fine
class Validators {
  //This Has been reused from my previous project (Hang out) which I have modified.
  Validators._();

  static final RegExp _email = RegExp(
    r"^[A-Za-z0-9.!#$%&'*+/=?^_`{|}~-]+@[A-Za-z0-9]"
    r"(?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?"
    r"(?:\.[A-Za-z0-9](?:[A-Za-z0-9-]{0,61}[A-Za-z0-9])?)+$",
  );
  static const int minPasswordLength = 6;

  static String? loginEmail(String? value) {
    final email = value?.trim() ?? '';
    if (email.isEmpty) return 'Enter your email';
    if (!_email.hasMatch(email)) return 'Enter a valid email address';
    return null;
  }

  static String? signupEmail(String? value) => loginEmail(value);
  static String? loginUsername(String? value) => loginEmail(value);
  static String? signupUsername(String? value) => signupEmail(value);

  static String? loginPassword(String? value) {
    if (value == null || value.isEmpty) return 'Enter your password';
    return null;
  }

  static String? signupPassword(String? value) {
    if (value == null || value.isEmpty) return 'Choose a password';
    if (value.length < minPasswordLength) {
      return 'Password must be at least $minPasswordLength characters';
    }
    return null;
  }
}
