import 'package:dto_helpers/string-validator/index.dart';
import 'package:dto_helpers/types/index.dart';

class IsEnum extends PropertyValidate {
  dynamic value;
  bool isOptional;
  String? propertyName;

  List<Enum> values;
  IsEnum({
    this.isOptional = false,
    required this.value,
    required this.values,
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
    final stringValidate = IsString(value: value).validate();
    if (!stringValidate.isValid) {
      return ValidationResult(
          isValid: false,
          message: getMessage('$propertyName must be a string'));
    }
    try {
      values.byName(value);
    } catch (e) {
      return ValidationResult(
          isValid: false,
          message: getMessage(
              '$propertyName must be a valid enum among ${values.map((e) {
            return e.name;
          })}'));
    }

    return ValidationResult(isValid: true);
  }

  String? get invalidEnumMessage =>
      getMessage('$propertyName must be a enum of type ');

  String? getMessage(String message) => propertyName != null ? message : null;
}
