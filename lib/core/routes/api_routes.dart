class ApiRoutes {
  static const baseUrl = 'https://api.marinejobs.com/v1';

  // Auth
  static const login = '$baseUrl/auth/login';
  static const register = '$baseUrl/auth/register';
  static const logout = '$baseUrl/auth/logout';

  // Jobs
  static const jobs = '$baseUrl/jobs';
  static String jobById(String id) => '$baseUrl/jobs/$id';

  // Profile
  static const userProfile = '$baseUrl/user/profile';
}
