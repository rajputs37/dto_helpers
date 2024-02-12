<!--
This README describes the package. If you publish this package to pub.dev,
this README's contents appear on the landing page for your package.

For information about how to write a good package README, see the guide for
[writing package pages](https://dart.dev/guides/libraries/writing-package-pages).

For general information about developing packages, see the Dart guide for
[creating packages](https://dart.dev/guides/libraries/create-library-packages)
and the Flutter guide for
[developing packages and plugins](https://flutter.dev/developing-packages).
-->

# dto_helpers

DTO(Data transfer objects) validators package for [Flutter](https://flutter.io).
Supports all platforms.

## Getting Started

In your flutter project add the dependency:

```yml
dependencies:
  ...
  dto_helpers:
```

## Features

- String validator
- List validator
- Number validator
- Enum validator
- Boolean validator

## Usage

Declare a DTO class extending `DTOValidate`

```dart
import 'package:dto_helpers/dto_helpers.dart';

class SignInDTO extends DTOValidate {
  late String name;
  int? signInCode;
  SignInDTO({required this.name});

  factory SignInDTO.fromJson(dynamic json) {
    return SignInDTO(name: json['name'],signInCode: json['signInCode']);
  }

  QrCodeDTO.empty();

  @override
  ValidationResult validate(dynamic json) {
    // you can chain different validators in the below method
    return super.validateAll([
      IsString(
          value: json['name'],
          // validation result will have proper message only if properyName is provided
          propertyName: 'name'),
       IsNumber(
        value: json['signInCode'],
        isOptional: true
       )
    ]);
  }
}

// usage of above class

// json will come from network data
final ValidationResult validationResult =  SignInDTO.empty().validate(json);
if(!validationResult.isValid){
    throw Error('Validation error ${validationResult.message}')
}
SignInDTO signInDTO=SignInDTO.fromJson(json);

```

#### IsString

This does the basic check of whether the data is string or not.Most of the options are self-explanatory.

```
IsString(
    value,
    isOptional, // will ignore validation if value is null
    isEmail,
    contains,
    notContains,
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
    isIP,
    isUppercase,
    isIn,// String[],
    maxLen,
    minLen,
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
)
```

#### IsNumber

This does the basic check of whether the data is number or not.

```
IsNumber(
    value,
    isOptional, // will ignore validation if value is null
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
    isNegative,
    isPositive,
    isDivisibleBy,
    max,
    min
)
```

#### IsEnum

This does the basic check of whether the data is an enum or not.

```
enum ClientDeviceType { android, ios }

IsEnum(
    value,
    values, // pass enum values, example ClientDeviceType.values
    isOptional, // will ignore validation if value is null
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
)
```

#### IsBoolean

This does the basic check of whether the data is an boolean or not.

```

IsBoolean(
    value,
    isOptional, // will ignore validation if value is null
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
)
```

#### IsList

This does the basic check of whether the data is a list or not.

```

IsList(
    value,
    maxSize,
    minSize,
    nested, // this property should be a function which will applied to each element of the array. Function should return any one of the propertValidate types, like IsString, IsNumber, IsBoolean, IsEnum or IsList. please see example below
    isOptional, // will ignore validation if value is null
    propertyName, // it will contruct a message whenever validation fails, if propertyName is passed
)

IsList(value: ['test','test2'], nested: (element){
    return IsString(value:element,maxLen: 4);
})
```
