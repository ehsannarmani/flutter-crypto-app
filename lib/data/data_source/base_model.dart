import 'package:dio/dio.dart';

class BaseModel <T>{
  late ResponseStatus status;
  late T data;
  late String message;

  BaseModel.loading(this.message) : status = ResponseStatus.Loading;
  BaseModel.success(this.data) : status = ResponseStatus.Success;
  BaseModel.failed(this.message) : status = ResponseStatus.Failed;

  @override
  String toString() {
      return "Status: $status \n message: $message \n data: $data";
  }
}

enum ResponseStatus{ Loading,Success,Failed}