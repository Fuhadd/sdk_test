class CustomValidator {
  static String? generalValidator({
    required String? value,
    required String? name,
    required String label,
    required String? dataType,
    required String inputType,
    required String? minMaxConstraint,
    required String? errorMsg,
    required int min,
    required int? max,
  }) {
    if (value == null) return '$label field is a required field';

    // var label = item['label'].toString?().toLowerCase();
    // var dataType = item['data_type'].toString().toLowerCase();

    if (inputType.toLowerCase() == "date") {
      return validateDate(
        value,
        label,
        minMaxConstraint,
        min,
        max,
        error: errorMsg,
      );
    }
    // else if ((item['data_url'].toString() != 'null' ||
    //     name.toString().toLowerCase().contains('is_full_year') ||
    //     name.toLowerCase().contains('stock_keeping'))) {
    //   return null;
    // }
    else if (label.toLowerCase().contains('image')) {
      return null;
    } else {
      return CustomValidator.validateInput(
          value, label, minMaxConstraint, min, max,
          error: errorMsg);
    }
  }

  static String? validateInput(
    String value,
    String label,
    String? minMaxConstraint,
    int? min,
    int? max, {
    String? error,
  }) {
    try {
      if (label.toLowerCase().contains("email")) {
        // Regular expression for email validation
        RegExp emailRegex =
            RegExp(r"^[a-zA-Z0-9_.+-]+@[a-zA-Z0-9-]+\.[a-zA-Z0-9-.]+$");
        if (!emailRegex.hasMatch(value)) {
          return "Please enter a valid $label";
        }
      } else if (minMaxConstraint == "value" && min != null) {
        int newValue =
            value.isEmpty ? 0 : int.tryParse(removeCommas(value)) ?? 0;
        if (newValue < min) {
          return "$label cannot be less than $min";
        }
        if (max != null && newValue > max) {
          return "$label cannot be greater than $max";
        }
      } else if (minMaxConstraint == "length" && min != null) {
        if (value.length < min) {
          return "Enter a minimum of $min characters";
        }
        if (max != null && value.length > max) {
          return "Enter a maximum of $max characters";
        }
      }
      return null;
    } catch (e) {
      print(e.toString());
      print(e.toString());
    }
    return null;
  }

  static String? validateDate(
      String value, String label, minMaxConstraint, min, max,
      {error}) {
    if (minMaxConstraint == "value") {
      if (value.isEmpty) {
        return "$label is a required field";
      } else {
        int yearComparison = compareDateWithToday(value);
        if (yearComparison < min) {
          return "$label requires a minimum of $min years";
        } else if (max != null && yearComparison > max) {
          return "$label cannot be greater than $max years";
        } else {
          return null;
        }
      }
    }

    return null;
  }

  static int compareDateWithToday(String dateString) {
    DateTime providedDate = DateTime.parse(dateString);
    DateTime today = DateTime.now();
    int providedYear = providedDate.year;
    int currentYear = today.year;
    int yearComparison = currentYear - providedYear;
    return yearComparison;
  }

  static String removeCommas(String value) {
    return value.replaceAll(',', '');
  }
}
