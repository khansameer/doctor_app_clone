class ApiConfig {
  static const baseUrl = "https://junohealthapi-e30c9eb77359.herokuapp.com/api";
  //static const baseUrl1 ="https://junohealthapi-e30c9eb77359.herokuapp.com/api";
  static const registerUser = '$baseUrl/users/register';
  static const login = '$baseUrl/users/login';
  static const addDoctor = '$baseUrl/doctors/register';
  static const getDoctor = '$baseUrl/doctors';
  static const getSpecializations = '$baseUrl/specializations';
  static const getSymptoms = '$baseUrl/symptoms';
  static const getPatients = '$baseUrl/patients';
  static const addProcedureCharges = '$baseUrl/procedure-charges';
  static const getDoctorAppointments = '$baseUrl/appointments/doctor';
  static const getPatientDetails = '$baseUrl/doctors';
  // static const getPatientDetails = '$baseUrl/doctors';
  static const createAppointment = '$baseUrl/appointments';
  static const getUserDetailsBYID = '$baseUrl/users/edit';
  static const settingNotification = '$baseUrl/notifications';
  static const addPrescription = '$baseUrl/medications';
  static const getFeedback = '$baseUrl/feedback/doctor/672a8e078137e27f0cb18f84';
}
