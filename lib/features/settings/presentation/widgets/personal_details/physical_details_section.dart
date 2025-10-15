import 'package:flutter/cupertino.dart';

import '../../../../auth/data/model/user_profile.dart';
import 'birth_date_picker.dart';
import 'form_divider.dart';
import 'form_text_field.dart';
import 'gender_selector.dart';

class PhysicalDetailsSection extends StatelessWidget {
  final bool isMale;
  final DateTime? birthDate;
  final TextEditingController heightController;
  final TextEditingController weightController;
  final UserProfile? currentProfile;
  final ValueChanged<bool?> onGenderChanged;
  final ValueChanged<DateTime?> onDateSelected;

  const PhysicalDetailsSection({
    super.key,
    required this.isMale,
    required this.birthDate,
    required this.heightController,
    required this.weightController,
    required this.currentProfile,
    required this.onGenderChanged,
    required this.onDateSelected,
  });

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        GenderSelector(isMale: isMale, onChanged: onGenderChanged),
        const FormDivider(),
        BirthDatePicker(
          birthDate: birthDate,
          currentBornDate: currentProfile?.bornDate,
          onDateSelected: onDateSelected,
        ),
        const FormDivider(),
        FormTextField(
          controller: heightController,
          label: 'Height',
          hint: currentProfile?.height != null
              ? '${currentProfile!.height} cm'
              : 'Enter height in cm',
          keyboardType: TextInputType.number,
          suffix: 'cm',
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Height is required';
            final height = double.tryParse(value!);
            if (height == null || height <= 0) {
              return 'Enter valid height';
            }
            return null;
          },
        ),
        const FormDivider(),
        FormTextField(
          controller: weightController,
          label: 'Current Weight',
          hint: currentProfile?.weight != null
              ? '${currentProfile!.weight} kg'
              : 'Enter weight in kg',
          keyboardType: TextInputType.number,
          suffix: 'kg',
          validator: (value) {
            if (value?.isEmpty ?? true) return 'Weight is required';
            final weight = double.tryParse(value!);
            if (weight == null || weight <= 0) {
              return 'Enter valid weight';
            }
            return null;
          },
        ),
      ],
    );
  }
}
