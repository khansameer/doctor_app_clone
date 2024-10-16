import 'package:doctor_app/core/app_constants.dart';
import 'package:doctor_app/core/common/app_scaffold.dart';
import 'package:doctor_app/core/common/common_button_widget.dart';
import 'package:doctor_app/core/common/common_text_widget.dart';
import 'package:doctor_app/core/component/component.dart';
import 'package:doctor_app/core/image/image_path.dart';
import 'package:doctor_app/core/string/string_utils.dart';
import 'package:doctor_app/core/validation/validation.dart';
import 'package:flutter/material.dart';

class EditProfileScreen extends StatelessWidget {
  const EditProfileScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final _formKey = GlobalKey<FormState>();
    return AppScaffold(
      appBar: commonAppBar(title: 'EDIT PROFILE'),
      child: ListView(
        padding: const EdgeInsets.symmetric(vertical: 20),
        children: [
          Align(
            child: Stack(
              clipBehavior: Clip.none,
              children: [
                //Circle Image
                Container(
                  width: 120,
                  height: 120,
                  decoration: BoxDecoration(
                    color: Colors.green,
                    shape: BoxShape.circle,
                    image: const DecorationImage(
                      image: AssetImage(icLoginLogo),
                      fit: BoxFit.contain,
                    ),
                    border: Border.all(color: Colors.amber, width: 0.5),
                  ),
                ),
                // Edit icon
                Positioned(
                  bottom: -10,
                  right: 45,
                  child: Container(
                    alignment: Alignment.center,
                    height: 30,
                    width: 30,
                    decoration: const BoxDecoration(
                      shape: BoxShape.circle,
                      color: Colors.white,
                      boxShadow: [
                        BoxShadow(
                          color: Colors.amber,
                          blurRadius: 1.0,
                        ),
                      ],
                    ),
                    child: IconButton(
                      onPressed: () {},
                      icon: const Icon(
                        Icons.edit,
                        color: Colors.amber,
                        size: 16,
                      ),
                    ),
                  ),
                ),

                // Additional items can be added here
              ],
            ),
          ),

          CommonTextWidget(
            text: "Dr. Richard Besser",
            fontWeight: FontWeight.w600,
            top: 15,
            marginBottom: 15,
            fontSize: 14,
            textColor: Colors.black.withOpacity(0.8),
            textAlign: TextAlign.center,
          ),
          const Divider(),
          const SizedBox(height: 10),
          //Form
          Form(
            child: Column(
              children: [
                commonTextFiledView(
                  title: 'Full name',
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return emptyEmail;
                    }
                    if (!Validation.validateEmail(value.toString())) {
                      return emailValidationMsg;
                    }
                    return null;
                  },
                  topTextField: ten,
                ),
                const SizedBox(height: 10),
                commonTextFiledView(
                  title: 'Email Address',
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return emptyEmail;
                    }
                    if (!Validation.validateEmail(value.toString())) {
                      return emailValidationMsg;
                    }
                    return null;
                  },
                  topTextField: ten,
                ),
                const SizedBox(height: 10),
                commonTextFiledView(
                  title: mobileNumber,
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return emptyEmail;
                    }
                    if (!Validation.validateEmail(value.toString())) {
                      return emailValidationMsg;
                    }
                    return null;
                  },
                  topTextField: ten,
                ),
                const SizedBox(height: 10),
                commonTextFiledView(
                  title: specialization,
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return emptyEmail;
                    }
                    if (!Validation.validateEmail(value.toString())) {
                      return emailValidationMsg;
                    }
                    return null;
                  },
                  topTextField: ten,
                ),
                const SizedBox(height: 10),
                commonTextFiledView(
                  title: 'How many years experience?',
                  validator: (value) {
                    if (value.toString().trim().isEmpty) {
                      return emptyEmail;
                    }
                    if (!Validation.validateEmail(value.toString())) {
                      return emailValidationMsg;
                    }
                    return null;
                  },
                  topTextField: ten,
                ),
                const SizedBox(height: 10),
                commonTextFiledView(
                  title: 'Address',
                  maxLines: 4,
                  topTextField: 10,
                ),
                const SizedBox(height: 20),
                CommonButtonWidget(
                  text: 'Save Changes',
                  fontWeight: FontWeight.w700,
                )
              ],
            ),
          ),
        ],
      ),
    );
  }
}
