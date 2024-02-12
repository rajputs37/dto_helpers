import 'package:dto_helpers/types/index.dart';

class IsList extends PropertyValidate {
  dynamic value;
  bool isOptional;
  String? propertyName;
  int? maxSize, minSize;

  PropertyValidate Function(dynamic element)? nested;
  IsList(
      {this.isOptional = false,
      required this.value,
      this.propertyName,
      this.maxSize,
      this.minSize,
      this.nested});

  @override
  ValidationResult validate() {
    if (isOptional && value == null) {
      return ValidationResult(isValid: true);
    }

    if (!isOptional && value == null) {
      return ValidationResult(
          isValid: false, message: getMessage('missing $propertyName'));
    }

    if (value is! List) {
      return ValidationResult(isValid: false, message: invalidArrayMessage);
    }

    if (!(maxSize == null) && value.length > maxSize) {
      return ValidationResult(isValid: false, message: maxSizeMessage);
    }

    if (!(minSize == null) && value.length < minSize) {
      return ValidationResult(isValid: false, message: minSizeMessage);
    }

    if (!(nested == null)) {
      for (var element in value) {
        final test = nested!(element).validate();
        if (!test.isValid) {
          return ValidationResult(
              isValid: false,
              message:
                  '${propertyName ?? ''}${propertyName != null ? ':' : ''}${test.message}');
        }
      }
    }
    return ValidationResult(isValid: true);
  }

  String? get invalidArrayMessage =>
      getMessage('$propertyName must be an array');

  String? get maxSizeMessage => getMessage(
      '$propertyName must be an array of length less than or equal to $maxSize');
  String? get minSizeMessage => getMessage(
      '$propertyName must be an array of length greater than or equal to $minSize');

  String? getMessage(String message) => propertyName != null ? message : null;
}
