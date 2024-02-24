
import 'package:anchor_getx/data/models/ErrorMsg.dart';

class BaseVo {
  bool valid;
  String? errorCode;
  String? errorMessage;
  List<ErrorMsg> errors;

  BaseVo() : valid = true, errors = [];

  bool isValid() {
    return valid;
  }

  void setValid(bool valid) {
    this.valid = valid;
  }

  String? getErrorCode() {
    return errorCode;
  }

  void setErrorCode(String errorCode) {
    this.errorCode = errorCode;
  }

  String? getErrorMessage() {
    return errorMessage;
  }

  void setErrorMessage(String errorMessage) {
    this.errorMessage = errorMessage;
  }

  List<ErrorMsg> getErrors() {
    return errors;
  }
}
