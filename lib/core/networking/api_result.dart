import 'api_error_model.dart';

class ApiResult<T> {
  ApiResult._();
  factory ApiResult.success(T data) = Success<T>;
  factory ApiResult.failure(ApiErrorModel e) = Failure<T>;
  R when<R>({
    required R Function(T data) onSuccess,
    required R Function(ApiErrorModel error) onError,
  }) {
    return this is Success<T>
        ? onSuccess((this as Success<T>).data)
        : onError((this as Failure<T>).error);
  }
}

class Success<T> extends ApiResult<T> {
  final T data;

  Success(this.data) : super._();
}

class Failure<T> extends ApiResult<T> {
  final ApiErrorModel error;

  Failure(this.error) : super._();
}
