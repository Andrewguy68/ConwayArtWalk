// the info shown on the about page
// it lives in firestore at config/about so the company can change it
// if a field is missing or empty in firestore, the default below is used
class AboutInfo {
  final String blurb;
  final String address;
  final String hours;
  final String email;
  final String phone;

  // full links,
  final String instagram;
  final String facebook;

  const AboutInfo({
    required this.blurb,
    required this.address,
    required this.hours,
    required this.email,
    required this.phone,
    required this.instagram,
    required this.facebook,
  });

  // what shows up if firestore cant be reached (like bad signal at the art walk)
  // info is from createconway.com
  static const AboutInfo defaults = AboutInfo(
    blurb: 'Create Conway is a nonprofit, founded in 2020, that works to make Conway an arts, culture, and entertainment destination. It runs Conway Art Walk, a free event on the first Friday of the month that fills downtown with live music, pop-up galleries, and hands-on activities for all ages.',
    address: '1100 Oak St, Conway, AR 72034',
    hours: 'Office: Monday - Friday, 9am - 5pm',
    email: 'info@createconway.com',
    phone: '(501) 232-1133',
    instagram: 'https://www.instagram.com/conwayartwalk/',
    facebook: 'https://www.facebook.com/conwayartwalk/',
  );

  // this builds the info from the firestore doc
  factory AboutInfo.fromMap(Map<String, dynamic> data) {
    // uses the default when a field is missing or just spaces
    String pick(String key, String fallback) {
      final value = data[key]?.toString().trim();
      return (value == null || value.isEmpty) ? fallback : value;
    }

    return AboutInfo(
      blurb: pick('blurb', defaults.blurb),
      address: pick('address', defaults.address),
      hours: pick('hours', defaults.hours),
      email: pick('email', defaults.email),
      phone: pick('phone', defaults.phone),
      instagram: pick('instagram', defaults.instagram),
      facebook: pick('facebook', defaults.facebook),
    );
  }
}