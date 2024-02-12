import 'package:dto_helpers/types/index.dart';
import 'package:validators/validators.dart' as validators;

class IsNumber extends PropertyValidate {
  dynamic value;
  bool isOptional, isNegative, isPositive;
  String? propertyName;
  int? max, min, isDivisibleBy;

  IsNumber(
      {this.isOptional = false,
      required this.value,
      this.propertyName,
      this.isNegative = false,
      this.isPositive = false,
      this.isDivisibleBy,
      this.max,
      this.min});

  @override
  ValidationResult validate() {
    if (isOptional && value == null) {
      return ValidationResult(isValid: true);
    }

    if (!isOptional && value == null) {
      return ValidationResult(
          isValid: false, message: getMessage('missing $propertyName'));
    }

    if (value is! num && !validators.isNumeric(value.toString())) {
      return ValidationResult(isValid: false, message: invalidNumberMessage);
    }
    final newValue = value = num.parse(value.toString());
    if (isNegative && newValue > -1) {
      return ValidationResult(isValid: false, message: notNegativeMessage);
    }
    if (isPositive && newValue < 0) {
      return ValidationResult(isValid: false, message: notPositiveMessage);
    }

    if (isDivisibleBy != null) {
      try {
        if (newValue % 1 != 0) {
          return ValidationResult(
              isValid: false, message: notDivisibleByMessage);
        }
        if ((newValue.toInt()) % isDivisibleBy! != 0) {
          return ValidationResult(
              isValid: false, message: notDivisibleByMessage);
        }
      } catch (e) {
        return ValidationResult(isValid: false, message: notDivisibleByMessage);
      }
    }

    if (max != null && newValue > max!.toDouble()) {
      return ValidationResult(
          isValid: false, message: incorrectMaxRangeInvalidMessage);
    }

    if (min != null && newValue < min!.toDouble()) {
      return ValidationResult(
          isValid: false, message: incorrectMinRangeInvalidMessage);
    }

    return ValidationResult(isValid: true);
  }

  String? get invalidNumberMessage =>
      getMessage('$propertyName must be a number');

  String? get notNegativeMessage =>
      getMessage('$propertyName must be negative');
  String? get notPositiveMessage =>
      getMessage('$propertyName must be positive');

  String? get notDivisibleByMessage => getMessage(isDivisibleBy == 0
      ? 'Division by zero not possible'
      : '$propertyName must be divisble by $isDivisibleBy');

  String? get incorrectMaxRangeInvalidMessage =>
      getMessage('$propertyName should be less than or equal to $max');

  String? get incorrectMinRangeInvalidMessage =>
      getMessage('$propertyName should be greater than or equal to $min');

  String? getMessage(String message) => propertyName != null ? message : null;
}
