class AppRoutes {
  // Auth
  static const login = 'login';
  static const register = 'register';
  static const String emailVerification = '/email-verification';

  // Dashboards
  static const runnerHomepage = '/homepage/runner';
  static const staffHomepage = '/homepage/staff';

  // Profile
  static const String profile = '/profile';
  static const String editProfile = '/profile/edit';

  // staff event

  // runner event

  // scan qr

  // runner map
}


// /staff/events
// /staff/events/create
// /staff/events/view/:eventId
// /staff/events/update/:eventId
// /staff/events/deactivate/:eventId

// /runner/events
// /runner/events/view/:eventId
// /runner/events/register/:eventId
// /runner/events/qr/:registrationId
// /runner/events/request-wristband/:registrationId

// /scan-qr
// /scan-qr/result

// /sos/activate
// /sos/response/:sosId
// /sos/live-map/:sosId

// /runner/map