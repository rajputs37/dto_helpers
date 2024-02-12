import 'package:dto_helpers/string-utils/index.dart';
import 'package:dto_helpers/types/index.dart';
import 'package:validators/validators.dart' as validators;

class IsString extends PropertyValidate {
  dynamic value;
  bool isOptional,
      ignoreCase,
      isEmail,
      isUrl,
      isAlpha,
      isAlphanumeric,
      isBase64,
      isCreditCard,
      isDate,
      isJSON,
      isLowercase,
      isUppercase,
      isUUID,
      isIP;
  String? propertyName, contains, notContains, matches;
  int? length, maxLen, minLen;
  List<String> isIn;

  IsString(
      {this.isOptional = false,
      required this.value,
      this.propertyName,
      this.contains,
      this.notContains,
      this.ignoreCase = false,
      this.isEmail = false,
      this.isUrl = false,
      this.isAlpha = false,
      this.isAlphanumeric = false,
      this.isBase64 = false,
      this.isCreditCard = false,
      this.isDate = false,
      this.isJSON = false,
      this.isLowercase = false,
      this.isUUID = false,
      this.isIP = false,
      this.isUppercase = false,
      this.isIn = const [],
      this.length,
      this.maxLen,
      this.minLen});

  @override
  ValidationResult validate() {
    if (isOptional && value == null) {
      return ValidationResult(isValid: true);
    }

    if (!isOptional && value == null) {
      return ValidationResult(
          isValid: false, message: getMessage('missing $propertyName'));
    }

    if (value is! String) {
      return ValidationResult(isValid: false, message: invalidStringMessage);
    }

    if (!isOptional && value.toString().isEmpty) {
      return ValidationResult(isValid: false, message: emptyStringMessage);
    }
    if (contains != null &&
        !Utils.contains(value, contains ?? '', ignoreCase: ignoreCase)) {
      return ValidationResult(isValid: false, message: containsInvalidMessage);
    }

    if (notContains != null &&
        Utils.contains(value, notContains ?? '', ignoreCase: ignoreCase)) {
      return ValidationResult(
          isValid: false, message: notContainsInvalidMessage);
    }

    if (isEmail && !validators.isEmail(value)) {
      return ValidationResult(isValid: false, message: notEmailInvalidMessage);
    }

    if (length != null && !validators.isLength(value, length ?? 0, length)) {
      return ValidationResult(
          isValid: false, message: incorrectLengthInvalidMessage);
    }

    if (maxLen != null && !validators.isLength(value, 0, maxLen)) {
      return ValidationResult(
          isValid: false, message: incorrectMaxLengthInvalidMessage);
    }

    if (minLen != null && !validators.isLength(value, minLen ?? 0)) {
      return ValidationResult(
          isValid: false, message: incorrectMinLengthInvalidMessage);
    }

    if (isUrl && !validators.isURL(value)) {
      return ValidationResult(isValid: false, message: incorrectUrlMessage);
    }

    if (matches != null && !validators.matches(value, matches)) {
      return ValidationResult(isValid: false, message: incorrectMatchMessage);
    }

    if (isIn.isNotEmpty && !(validators.isIn(value, isIn) ?? false)) {
      return ValidationResult(isValid: false, message: incorrectIsInMessage);
    }

    if (isAlpha && !validators.isAlpha(value)) {
      return ValidationResult(isValid: false, message: incorrectIsAlphaMessage);
    }

    if (isAlphanumeric && !validators.isAlphanumeric(value)) {
      return ValidationResult(
          isValid: false, message: incorrectIsAlphaNumericMessage);
    }

    if (isBase64 && !validators.isBase64(value)) {
      return ValidationResult(isValid: false, message: incorrectBase64Message);
    }

    if (isCreditCard && !validators.isCreditCard(value)) {
      return ValidationResult(
          isValid: false, message: incorrectCreditCardMessage);
    }

    if (isDate && !validators.isDate(value)) {
      return ValidationResult(isValid: false, message: incorrectDateMessage);
    }
    if (isJSON && !validators.isJSON(value)) {
      return ValidationResult(isValid: false, message: incorrectJSONMessage);
    }
    if (isLowercase && !validators.isLowercase(value)) {
      return ValidationResult(
          isValid: false, message: incorrectLowercaseMessage);
    }
    if (isUUID && !validators.isUUID(value)) {
      return ValidationResult(isValid: false, message: incorrectUUIDMessage);
    }

    if (isUppercase && !validators.isUppercase(value)) {
      return ValidationResult(
          isValid: false, message: incorrectUppercaseMessage);
    }

    if (isIP && !validators.isIP(value)) {
      return ValidationResult(isValid: false, message: incorrectIPMessage);
    }

    return ValidationResult(isValid: true);
  }

  String? get invalidStringMessage =>
      getMessage('$propertyName must be a string');
  String? get emptyStringMessage =>
      getMessage('$propertyName should not be empty');
  String? get containsInvalidMessage =>
      getMessage('$propertyName must contain $contains');

  String? get notContainsInvalidMessage =>
      getMessage('$propertyName must not contain $notContains');

  String? get notEmailInvalidMessage =>
      getMessage('$propertyName must be an email');

  String? get incorrectLengthInvalidMessage =>
      getMessage('$propertyName must be of length $length');

  String? get incorrectMaxLengthInvalidMessage => getMessage(
      '$propertyName length should be less than or equal to $maxLen');

  String? get incorrectMinLengthInvalidMessage => getMessage(
      '$propertyName length should be greater than or equal to $minLen');

  String? get incorrectUrlMessage =>
      getMessage('$propertyName should be a URL');

  String? get incorrectMatchMessage =>
      getMessage('$propertyName should match $matches');

  String? get incorrectIsInMessage =>
      getMessage('$propertyName should be a value in $isIn');

  String? get incorrectIsAlphaMessage =>
      getMessage('$propertyName should only consists alphabet');

  String? get incorrectIsAlphaNumericMessage =>
      getMessage('$propertyName should only consists of alphanumeric');

  String? get incorrectBase64Message =>
      getMessage('$propertyName should be a base64 stirng');

  String? get incorrectCreditCardMessage =>
      getMessage('$propertyName should be a valid card');

  String? get incorrectDateMessage =>
      getMessage('$propertyName should be a valid date');

  String? get incorrectJSONMessage =>
      getMessage('$propertyName should be a valid json');

  String? get incorrectLowercaseMessage =>
      getMessage('$propertyName should be a all lowercase string');

  String? get incorrectUppercaseMessage =>
      getMessage('$propertyName should be a all uppercase string');

  String? get incorrectIPMessage => getMessage('$propertyName should be an IP');

  String? get incorrectUUIDMessage =>
      getMessage('$propertyName should be a valid UUID');

  String? getMessage(String message) => propertyName != null ? message : null;
}
