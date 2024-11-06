import 'dart:io';
import 'dart:typed_data';

import 'package:doctor_app/core/common/file_picker_helper.dart';
import 'package:file_picker/file_picker.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:image_cropper/image_cropper.dart';

class ProfileProvider extends ChangeNotifier{

  FilePickerResult? _pickedFile;

  FilePickerResult? get pickedFile => _pickedFile;
  String? _imagePath;
  Uint8List? _imageBytes;
  Future<void> pickFiles({required BuildContext context}) async {
  //  final result = await FilePicker.platform.pickFiles(allowMultiple: true);
    final result = await FilePickerHelper.pickFile( allowedExtensions: ['jpg', 'png']);
    if (result != null) {
      _pickedFile = result;
      setFilePath=result;
      Uint8List? fileBytes = result.files.single.bytes;
     // cropImage(sourcePath: _pickedFile?.files.single.path??'',context: context);
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

}