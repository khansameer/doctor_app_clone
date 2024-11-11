import 'package:doctor_app/provider/admin_dashboard_provider.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:provider/provider.dart';

// Models for Appointment, Patient, and Doctor remain unchanged

class MainVideoCall extends StatelessWidget {
  final List<AppointmentModel> appointments = [
    // Sample data, can be fetched from an API or other source
    AppointmentModel.fromJson({
      "id": "673081468865ddc6507a4fd3",
      "dateTime": "2024-11-11T01:00:00.000Z",
      "status": "scheduled",
      "appointment_type": "emergency",
      "isVirtual": true,
      "patient": {
        "id": "672ab5d82a8747576ca04dfc",
        "name": "Corey Aguilar",
        "email": "corey.brown@gmail.com",
        "phoneNumber": "1234567890",
        "profile": {"profilePicture": "https://res.cloudinary.com/dg6jsgmmh/image/upload/v1730881731/profile_pictures/patients/bczaqdyjdmtqkt0f8kza.png"},
        "gender": "male"
      },
      "doctor": {
        "id": "672a8e078137e27f0cb18f84",
        "name": "Richard Stevens"
      }
    }),
    AppointmentModel.fromJson({
      "id": "6731f4f8326258b8227e9d82",
      "dateTime": "2024-11-11T10:00:00.000Z",
      "status": "scheduled",
      "appointment_type": "emergency",
      "isVirtual": true,
      "patient": {
        "id": "672cfb6e497daed0f192c1bd",
        "name": "Patricia Brown",
        "email": "patricia.brown@gmail.com",
        "phoneNumber": "9512472957",
        "profile": {"profilePicture": "https://res.cloudinary.com/dg6jsgmmh/image/upload/v1731001757/profile_pictures/patients/qkmiaejvhew4yagnbnpr.jpg"},
        "gender": "female"
      },
      "doctor": {
        "id": "672a8e078137e27f0cb18f84",
        "name": "Richard Stevens"
      }
    }),
    AppointmentModel.fromJson({
      "id": "6731f4f8326258b8227e9d82",
      "dateTime": "2024-11-11T10:00:00.000Z",
      "status": "scheduled",
      "appointment_type": "emergency",
      "isVirtual": true,
      "patient": {
        "id": "672cfb6e497daed0f192c1bd",
        "name": "Patricia Brown",
        "email": "patricia.brown@gmail.com",
        "phoneNumber": "9512472957",
        "profile": {"profilePicture": "https://res.cloudinary.com/dg6jsgmmh/image/upload/v1731001757/profile_pictures/patients/qkmiaejvhew4yagnbnpr.jpg"},
        "gender": "female"
      },
      "doctor": {
        "id": "672a8e078137e27f0cb18f84",
        "name": "Richard Stevens"
      }
    }),
    AppointmentModel.fromJson({
      "id": "6731f4f8326258b8227e9d82",
      "dateTime": "2024-11-12T10:00:00.000Z",
      "status": "scheduled",
      "appointment_type": "emergency",
      "isVirtual": true,
      "patient": {
        "id": "672cfb6e497daed0f192c1bd",
        "name": "Patricia Brown",
        "email": "patricia.brown@gmail.com",
        "phoneNumber": "9512472957",
        "profile": {"profilePicture": "https://res.cloudinary.com/dg6jsgmmh/image/upload/v1731001757/profile_pictures/patients/qkmiaejvhew4yagnbnpr.jpg"},
        "gender": "female"
      },
      "doctor": {
        "id": "672a8e078137e27f0cb18f84",
        "name": "Richard Stevens"
      }
    }),
    AppointmentModel.fromJson({
      "id": "6731f4f8326258b8227e9d82",
      "dateTime": "2024-11-12T10:00:00.000Z",
      "status": "scheduled",
      "appointment_type": "emergency",
      "isVirtual": true,
      "patient": {
        "id": "672cfb6e497daed0f192c1bd",
        "name": "Patricia Brown",
        "email": "patricia.brown@gmail.com",
        "phoneNumber": "9512472957",
        "profile": {"profilePicture": "https://res.cloudinary.com/dg6jsgmmh/image/upload/v1731001757/profile_pictures/patients/qkmiaejvhew4yagnbnpr.jpg"},
        "gender": "female"
      },
      "doctor": {
        "id": "672a8e078137e27f0cb18f84",
        "name": "Richard Stevens"
      }
    }),
    AppointmentModel.fromJson({
      "id": "6731f4f8326258b8227e9d82",
      "dateTime": "2024-11-12T10:00:00.000Z",
      "status": "scheduled",
      "appointment_type": "emergency",
      "isVirtual": true,
      "patient": {
        "id": "672cfb6e497daed0f192c1bd",
        "name": "Patricia Brown",
        "email": "patricia.brown@gmail.com",
        "phoneNumber": "9512472957",
        "profile": {"profilePicture": "https://res.cloudinary.com/dg6jsgmmh/image/upload/v1731001757/profile_pictures/patients/qkmiaejvhew4yagnbnpr.jpg"},
        "gender": "female"
      },
      "doctor": {
        "id": "672a8e078137e27f0cb18f84",
        "name": "Richard Stevens"
      }
    }),
  ];

  Map<String, List<AppointmentModel>> groupAppointmentsByDate(List<AppointmentModel> appointments) {
    Map<String, List<AppointmentModel>> groupedAppointments = {};

    for (var appointment in appointments) {
      String formattedDate = DateFormat('yyyy-MM-dd').format(appointment.dateTime);
      if (groupedAppointments.containsKey(formattedDate)) {
        groupedAppointments[formattedDate]?.add(appointment);
      } else {
        groupedAppointments[formattedDate] = [appointment];
      }
    }

    return groupedAppointments;
  }

  @override
  Widget build(BuildContext context) {
    var groupedAppointments = groupAppointmentsByDate(appointments);

    return ChangeNotifierProvider(
      create: (context) => AdminDashboardProvider()
        ..initializeHoverStates(appointments.length), // Initialize hover states based on list size
      child: Scaffold(
        appBar: AppBar(title: Text('Appointments')),
        body: Consumer<AdminDashboardProvider>(
          builder: (context, hoverStateProvider, child) {
            return ListView.builder(
              itemCount: groupedAppointments.keys.length,
              itemBuilder: (context, index) {
                String date = groupedAppointments.keys.elementAt(index);
                List<AppointmentModel> appointmentsForDate = groupedAppointments[date]!;

                return Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Padding(
                      padding: const EdgeInsets.all(8.0),
                      child: Text(
                        DateFormat('yyyy-MM-dd').format(DateTime.parse(date)),
                        style: TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
                      ),
                    ),
                    ...appointmentsForDate.map((appointment) {
                      int appointmentIndex = appointments.indexOf(appointment);

                      return ListTile(
                        title: Text(appointment.patient.name),
                        subtitle: Text('${DateFormat('HH:mm').format(appointment.dateTime)} - ${appointment.appointmentType}'),
                        leading: CircleAvatar(
                          backgroundImage: NetworkImage(appointment.patient.profile.profilePicture),
                        ),
                        trailing: MouseRegion(
                          onEnter: (_) {
                            hoverStateProvider.setHoverState(appointmentIndex, true);
                          },
                          onExit: (_) {
                            hoverStateProvider.setHoverState(appointmentIndex, false);
                          },
                          child: Icon(
                            appointment.isVirtual ? Icons.video_call : Icons.medical_services,
                            color: hoverStateProvider.getHoverState(appointmentIndex) ? Colors.green : Colors.blue,
                          ),
                        ),
                      );
                    }).toList(),
                  ],
                );
              },
            );
          },
        ),
      ),
    );
  }
}

class AppointmentModel {
  final String id;
  final DateTime dateTime;
  final String status;
  final String appointmentType;
  final bool isVirtual;
  final Patient patient;
  final Doctor doctor;

  AppointmentModel({
    required this.id,
    required this.dateTime,
    required this.status,
    required this.appointmentType,
    required this.isVirtual,
    required this.patient,
    required this.doctor,
  });

  factory AppointmentModel.fromJson(Map<String, dynamic> json) {
    return AppointmentModel(
      id: json['id'],
      dateTime: DateTime.parse(json['dateTime']),
      status: json['status'],
      appointmentType: json['appointment_type'],
      isVirtual: json['isVirtual'],
      patient: Patient.fromJson(json['patient']),
      doctor: Doctor.fromJson(json['doctor']),
    );
  }
}

class Patient {
  final String id;
  final String name;
  final String email;
  final String phoneNumber;
  final Profile profile;
  final String gender;

  Patient({
    required this.id,
    required this.name,
    required this.email,
    required this.phoneNumber,
    required this.profile,
    required this.gender,
  });

  factory Patient.fromJson(Map<String, dynamic> json) {
    return Patient(
      id: json['id'],
      name: json['name'],
      email: json['email'],
      phoneNumber: json['phoneNumber'],
      profile: Profile.fromJson(json['profile']),
      gender: json['gender'],
    );
  }
}

class Profile {
  final String profilePicture;

  Profile({
    required this.profilePicture,
  });

  factory Profile.fromJson(Map<String, dynamic> json) {
    return Profile(
      profilePicture: json['profilePicture'],
    );
  }
}

class Doctor {
  final String id;
  final String name;

  Doctor({
    required this.id,
    required this.name,
  });

  factory Doctor.fromJson(Map<String, dynamic> json) {
    return Doctor(
      id: json['id'],
      name: json['name'],
    );
  }
}
