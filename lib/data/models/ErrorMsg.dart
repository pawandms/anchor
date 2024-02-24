
class ErrorMsg {
  String? errorCode;
  String? filedName;
  String? fieldValue;

  ErrorMsg(this.errorCode);

  ErrorMsg.withFieldName(this.errorCode, this.filedName);

  ErrorMsg.full(this.errorCode, this.filedName, this.fieldValue);

  String? get getFieldName => filedName;

  set setFieldName(String filedName) {
    this.filedName = filedName;
  }

  String? get getFieldValue => fieldValue;

  set setFieldValue(String fieldValue) {
    this.fieldValue = fieldValue;
  }

  String? get getErrorCode => errorCode;

  set setErrorCode(String errorCode) {
    this.errorCode = errorCode;
  }
}

