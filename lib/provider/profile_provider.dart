import 'dart:convert';
import 'dart:io';

import 'package:doctor_app/screen/authentication/model/login_model.dart';
import 'package:doctor_app/screen/mobile_view/profile/model/user_details_model.dart';
import 'package:doctor_app/service/api_services.dart';
import 'package:doctor_app/service/gloable_status_code.dart';
import 'package:doctor_app/shared_preferences/preference_helper.dart';
import 'package:flutter/foundation.dart';
import 'package:doctor_app/core/common/file_picker_helper.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/service/network_repository.dart';
import 'package:file_picker/file_picker.dart';
import 'package:http/http.dart' as http;
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

import '../service/api_config.dart';

class ProfileProvider extends ChangeNotifier {
  final _service = ApiService();
  bool get isFetching => _isFetching;
  bool _isFetching = false;
  FilePickerResult? _pickedFile;

  FilePickerResult? get pickedFile => _pickedFile;

  Future<void> pickFiles({required BuildContext context}) async {
    final result =
        await FilePickerHelper.pickFile(allowedExtensions: ['jpg', 'png']);
    if (result != null) {
      _pickedFile = result;
      setFilePath = result;
      Uint8List? fileBytes = result.files.single.bytes;
      print('================_pickedFile${fileBytes}');
      notifyListeners();
    }
  }

  cropImage({required String sourcePath, required BuildContext context}) async {
    CroppedFile? croppedFile = await ImageCropper().cropImage(
      sourcePath: sourcePath,
      uiSettings: [
        AndroidUiSettings(
          toolbarTitle: 'Cropper',
          toolbarColor: Colors.deepOrange,
          toolbarWidgetColor: Colors.white,
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            //  CropAspectRatioPresetCustom(),
          ],
        ),
        IOSUiSettings(
          title: 'Cropper',
          aspectRatioPresets: [
            CropAspectRatioPreset.original,
            CropAspectRatioPreset.square,
            //  CropAspectRatioPresetCustom(), // IMPORTANT: iOS supports only one custom aspect ratio in preset list
          ],
        ),
        WebUiSettings(
          context: context,
        ),
      ],
    );
  }

  set setFilePath(FilePickerResult path) {
    _pickedFile = path;
    print('================_pickedFile${_pickedFile?.files.length}');
    notifyListeners();
  }

  String? _selectedGender;

  String? get selectedGender => _selectedGender;

  set setGenderValue(String newPin) {
    _selectedGender = newPin;
    notifyListeners();
  }

  String? _selectAppointment;

  String? get selectAppointment => _selectAppointment;

  set setAppointment(String newPin) {
    _selectAppointment = newPin;
    notifyListeners();
  }

  String? _selectTimeZone;

  String? get selectTimeZone => _selectTimeZone;

  set setTimeZoneValue(String newPin) {
    _selectTimeZone = newPin;
    notifyListeners();
  }

  String? _selectBloodGroup;

  String? get selectBloodGroup => _selectBloodGroup;

  set setBloodValue(String newPin) {
    _selectBloodGroup = newPin;
    notifyListeners();
  }

  String? _selectCountry;

  String? get selectCountry => _selectCountry;

  set setCountryValue(String newPin) {
    _selectCountry = newPin;
    notifyListeners();
  }

  String? _selectLanguage;

  String? get selectLanguage => _selectLanguage;

  set setLanguageValue(String newPin) {
    _selectLanguage = newPin;
    notifyListeners();
  }

  final List<String> itemGenderList = [
    'Male',
    'Female',
    'Other',
  ];

  List<String> timeZoneList = [
    "UTC (Coordinated Universal Time)",
    "GMT (Greenwich Mean Time)",
    "PST (Pacific Standard Time)",
    "EST (Eastern Standard Time)",
    "CST (Central Standard Time)",
    "MST (Mountain Standard Time)",
    "IST (Indian Standard Time)",
    "CET (Central European Time)",
    "EET (Eastern European Time)",
    "JST (Japan Standard Time)",
    "AEST (Australian Eastern Standard Time)",
    "AEDT (Australian Eastern Daylight Time)",
    "NZST (New Zealand Standard Time)",
    "HKT (Hong Kong Time)",
    "SGT (Singapore Time)",
    "BST (British Summer Time)",
    "CST (China Standard Time)",
    "WAT (West Africa Time)",
    "EAT (East Africa Time)",
    "CAT (Central Africa Time)",
    "SAST (South Africa Standard Time)",
    "AST (Atlantic Standard Time)",
    "AKST (Alaska Standard Time)",
    "HST (Hawaii Standard Time)",
    "ChST (Chamorro Standard Time)",
    "WIB (Western Indonesia Time)",
    "WITA (Central Indonesia Time)",
    "WIT (Eastern Indonesia Time)",
    "KST (Korea Standard Time)",
    "ACST (Australian Central Standard Time)",
    "ACDT (Australian Central Daylight Time)",
    "AWST (Australian Western Standard Time)",
    "ART (Argentina Time)",
    "WET (Western European Time)",
    "WEST (Western European Summer Time)"
  ];

  List<String> bloodGroupList = [
    "A+",
    "A-",
    "B+",
    "B-",
    "AB+",
    "AB-",
    "O+",
    "O-"
  ];
  List<String> countryList = [
    "Afghanistan",
    "Albania",
    "Algeria",
    "Andorra",
    "Angola",
    "Antigua and Barbuda",
    "Argentina",
    "Armenia",
    "Australia",
    "Austria",
    "Azerbaijan",
    "Bahamas",
    "Bahrain",
    "Bangladesh",
    "Barbados",
    "Belarus",
    "Belgium",
    "Belize",
    "Benin",
    "Bhutan",
    "Bolivia",
    "Bosnia and Herzegovina",
    "Botswana",
    "Brazil",
    "Brunei",
    "Bulgaria",
    "Burkina Faso",
    "Burundi",
    "Cabo Verde",
    "Cambodia",
    "Cameroon",
    "Canada",
    "Central African Republic",
    "Chad",
    "Chile",
    "China",
    "Colombia",
    "Comoros",
    "Congo (Congo-Brazzaville)",
    "Costa Rica",
    "Croatia",
    "Cuba",
    "Cyprus",
    "Czechia (Czech Republic)",
    "Denmark",
    "Djibouti",
    "Dominica",
    "Dominican Republic",
    "Ecuador",
    "Egypt",
    "El Salvador",
    "Equatorial Guinea",
    "Eritrea",
    "Estonia",
    "Eswatini ",
    "Ethiopia",
    "Fiji",
    "Finland",
    "France",
    "Gabon",
    "Gambia",
    "Georgia",
    "Germany",
    "Ghana",
    "Greece",
    "Grenada",
    "Guatemala",
    "Guinea",
    "Guinea-Bissau",
    "Guyana",
    "Haiti",
    "Honduras",
    "Hungary",
    "Iceland",
    "India",
    "Indonesia",
    "Iran",
    "Iraq",
    "Ireland",
    "Israel",
    "Italy",
    "Jamaica",
    "Japan",
    "Jordan",
    "Kazakhstan",
    "Kenya",
    "Kiribati",
    "Kuwait",
    "Kyrgyzstan",
    "Laos",
    "Latvia",
    "Lebanon",
    "Lesotho",
    "Liberia",
    "Libya",
    "Liechtenstein",
    "Lithuania",
    "Luxembourg",
    "Madagascar",
    "Malawi",
    "Malaysia",
    "Maldives",
    "Mali",
    "Malta",
    "Marshall Islands",
    "Mauritania",
    "Mauritius",
    "Mexico",
    "Micronesia",
    "Moldova",
    "Monaco",
    "Mongolia",
    "Montenegro",
    "Morocco",
    "Mozambique",
    "Myanmar (formerly Burma)",
    "Namibia",
    "Nauru",
    "Nepal",
    "Netherlands",
    "New Zealand",
    "Nicaragua",
    "Niger",
    "Nigeria",
    "North Korea",
    "North Macedonia",
    "Norway",
    "Oman",
    "Pakistan",
    "Palau",
    "Panama",
    "Papua New Guinea",
    "Paraguay",
    "Peru",
    "Philippines",
    "Poland",
    "Portugal",
    "Qatar",
    "Romania",
    "Russia",
    "Rwanda",
    "Saint Kitts and Nevis",
    "Saint Lucia",
    "Saint Vincent and the Grenadines",
    "Samoa",
    "San Marino",
    "Sao Tome and Principe",
    "Saudi Arabia",
    "Senegal",
    "Serbia",
    "Seychelles",
    "Sierra Leone",
    "Singapore",
    "Slovakia",
    "Slovenia",
    "Solomon Islands",
    "Somalia",
    "South Africa",
    "South Korea",
    "South Sudan",
    "Spain",
    "Sri Lanka",
    "Sudan",
    "Suriname",
    "Sweden",
    "Switzerland",
    "Syria",
    "Taiwan",
    "Tajikistan",
    "Tanzania",
    "Thailand",
    "Timor-Leste",
    "Togo",
    "Tonga",
    "Trinidad and Tobago",
    "Tunisia",
    "Turkey",
    "Turkmenistan",
    "Tuvalu",
    "Uganda",
    "Ukraine",
    "United Arab Emirates",
    "United Kingdom",
    "United States of America",
    "Uruguay",
    "Uzbekistan",
    "Vanuatu",
    "Vatican City",
    "Venezuela",
    "Vietnam",
    "Yemen",
    "Zambia",
    "Zimbabwe"
  ];

  List<String> languageList = [
    "English",
    "Spanish",
    "Mandarin",
    "Hindi",
    "Arabic",
    "Portuguese",
    "Bengali",
    "Russian",
    "Japanese",
    "Punjabi",
    "German",
    "Korean",
    "French",
    "Turkish",
    "Vietnamese",
    "Italian",
    "Urdu",
    "Persian",
    "Polish",
    "Dutch",
    "Romanian",
    "Greek",
    "Czech",
    "Hungarian",
    "Swedish",
    "Finnish",
    "Danish",
    "Norwegian",
    "Thai",
    "Indonesian",
    "Malay",
    "Hebrew",
    "Ukrainian",
    "Tamil",
    "Telugu",
    "Marathi",
    "Kannada",
    "Gujarati",
    "Malayalam",
    "Swahili",
    "Zulu",
    "Amharic",
    "Somali",
    "Filipino",
    "Sinhala",
    "Khmer",
    "Burmese",
    "Lao",
    "Mongolian",
    "Nepali",
    "Haitian Creole",
    "Serbian",
    "Croatian",
    "Slovak",
    "Bulgarian",
    "Lithuanian",
    "Latvian",
    "Estonian",
    "Basque",
    "Catalan",
    "Galician",
    "Icelandic",
    "Irish",
    "Welsh",
    "Scottish Gaelic",
    "Luxembourgish",
    "Macedonian",
    "Albanian",
    "Bosnian",
    "Afrikaans",
    "Pashto",
    "Fijian",
    "Samoan",
    "Tongan",
    "Maori"
  ];
  bool _isUploading = false;

  bool get isUploading => _isUploading;

  Future<int> uploadProfile(
      {File? frontImage,
      required BuildContext context,
      required Map<String, String> body}) async {
    _isUploading = true;
    notifyListeners();
    // var url = Uri.parse("https://yourapi.com/upload");
    String userId = await getUserID();
    var request = http.MultipartRequest(
      'PUT',
      Uri.parse('${ApiConfig.getDoctor}/$userId'),
    );
    String? token = await getAuthToken();
    printWrapped("basedsdsdUrl--$token");

    Map<String, String> headers = {
      "Authorization": "Bearer $token",
      "Content-type": "multipart/form-data"
    };
    String? fileName = frontImage?.path.split('/').last;
    /* frontImage!.path.isNotEmpty?  request.files.add(
      http.MultipartFile(
        'profilePicture',
        frontImage.readAsBytes().asStream(),
        frontImage.lengthSync(),
        filename: fileName,
       //contentType: MediaType('image','jpeg'),
      ),
    ):null;*/
    request.headers.addAll(headers);
    /* request.fields.addAll({
      "firstName": name??'',
      "lastName": category ?? '',
      "email": address??'',
      "phoneNumber": email??'',
      "dateOfBirth": latitude ?? '23.4087382',
      "gender": longitude ?? '72.9018021',
      "role": longitude ?? '72.9018021',
    });*/
    request.fields.addAll(body);
    print("request: " + request.toString());
    var res = await request.send();
    var response = await http.Response.fromStream(res);

    print('=======${response.statusCode}');
    if (response.statusCode == 200 || response.statusCode == 201) {
    } else {
      final parsedJson = jsonDecode(response.body.toString());
      final message = parsedJson['message'].toString();
      errorMessage = message;
      commonSessionError(context: context, isAuth: true);
    }
    //  _commonModel = CommonModel.fromJson(jsonDecode(response.body));

    /* if(_commonModel?.status==AppUtils.success){
      AppUtils.showMessage(context: context, message:"Profile successfully updated.",backgroundColor: Colors.green);
      // isEdit==true? Navigator.pushNamedAndRemoveUntil(context, RouteName.dashboard, (route) => false)
      if(isEdit==true){
        Navigator.pushNamedAndRemoveUntil(context, RouteName.dashboard, (route) => false);
      }
      else{

        var isCustomer1=await PreferenceHelper.getBool(key: PreferenceHelper.SELECTED_CUSTOMER);
        var isVendor1=await PreferenceHelper.getBool(key: PreferenceHelper.SELECTED_VENDOR);
        var isVendor=isVendor1!=null?isVendor1:false;
        var isCustomer=isCustomer1!=null?isCustomer1:false;
        isCustomer && isVendor == false
            ?Navigator.pushNamedAndRemoveUntil(
            context, RouteName.dashboard, (route) => false)
            : isVendor && isCustomer
            ? Navigator.pushNamed(
            context, RouteName.businessCardScreen)
            : isVendor && isCustomer == false
            ? Navigator.pushNamed(
            context, RouteName.businessCardScreen)
            : Navigator.pushNamedAndRemoveUntil(
            context, RouteName.dashboard, (route) => false);
      }
    }else
    {
      AppUtils.showMessageDialog(context: context,content:'${_commonModel?.error.toString()}',title: 'error'.tr().toCapitalize() );
    }*/
//    final result = jsonDecode(response.body) as Map<String, dynamic>;
    //   print("This is response:${_commonModel?.error.toString()}");
    _isUploading = false;
    notifyListeners();
    return res.statusCode;
  }

  UserDetailsModel? _userDetailsModel;

  UserDetailsModel? get userDetailsModel => _userDetailsModel;
  Future<void> getUserDetails({required BuildContext context}) async {
    _isFetching = true;
    notifyListeners();
    try {
      String userId = await getUserID();
      final response = await _service.callGetMethod(
        url: '${ApiConfig.getUserDetailsBYID}/$userId',
      );
      _userDetailsModel = UserDetailsModel.fromJson(json.decode(response));

      print('===$globalStatusCode');
      if (globalStatusCode == 200) {
        if (_userDetailsModel?.user?.sId != null) {
          await PreferenceHelper.setString(
              key: PreferenceHelper.name,
              value:
                  "${_userDetailsModel?.user?.firstName} ${_userDetailsModel?.user?.lastName}");
          await PreferenceHelper.setString(
              key: PreferenceHelper.email,
              value: '${_userDetailsModel?.user?.email}');
          await PreferenceHelper.setString(
              key: PreferenceHelper.userPhoto,
              value: '${_userDetailsModel?.user?.profile?.profilePicture}');

          /*   await PreferenceHelper.setString(key: 'userData', value: jsonEncode(response));

          await PreferenceHelper.setString(
              key: PreferenceHelper.name,
              value: "${_loginModel?.firstName} ${_loginModel?.lastName}");
          await PreferenceHelper.setString(
              key: PreferenceHelper.email, value: '${_loginModel?.email}');
          await PreferenceHelper.setString(
              key: PreferenceHelper.authToken, value: '${_loginModel?.token}');
          await PreferenceHelper.setString(
              key: PreferenceHelper.userID, value: '${_loginModel?.userId}');
          await PreferenceHelper.setBool(
              key: PreferenceHelper.isLOGIN, value: true);*/
        }
      } else if (globalStatusCode == 401) {
        commonSessionError(context: context, isAuth: true);
      } else {}
    } catch (e) {
      // _registerModel = RegisterModel(message: 'server_error'.tr());
    }
    _isFetching = false;
    notifyListeners();
  }
}
