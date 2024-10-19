class ApiConfig {
  //static const baseUrl="http://10.0.10.51:5001/api";
  static const baseUrl = "https://junohealthapi-e30c9eb77359.herokuapp.com/api";
  static const registerUser = '$baseUrl/users/register';
  static const login = '$baseUrl/users/login';
  static const addDoctor = '$baseUrl/doctors/register';
  static const getDoctor = '$baseUrl/doctors';
  static const getSpecializations = '$baseUrl/specializations';
  static const getSymptoms = '$baseUrl/symptoms';
  static const getPatients = '$baseUrl/patients';
}
