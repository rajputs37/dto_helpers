import 'package:dto_helpers/types/index.dart';

class IsBoolean extends PropertyValidate {
  dynamic value;
  bool isOptional;
  String? propertyName;

  IsBoolean({
    this.isOptional = false,
    required this.value,
    this.propertyName,
  });

  @override
  ValidationResult validate() {
    if (isOptional && value == null) {
      return ValidationResult(isValid: true);
    }

    if (!isOptional && value == null) {
      return ValidationResult(
          isValid: false, message: getMessage('missing $propertyName'));
    }

    if (value is! bool) {
      try {
        bool.parse(value.toString());
      } catch (e) {
        return ValidationResult(isValid: false, message: invalidBooleanMessage);
      }
    }

    return ValidationResult(isValid: true);
  }

  String? get invalidBooleanMessage =>
      getMessage('$propertyName must be a boolean');

  String? getMessage(String message) => propertyName != null ? message : null;
}
