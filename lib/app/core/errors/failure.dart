import 'package:equatable/equatable.dart';

class Failure extends Equatable {
  const Failure(this.message);
  final String message;
  @override
  String toString() {
    return message;
  }



  @override
  bool operator ==(Object other) {
    if (identical(this, other)) return true;

    return other is Failure && other.message == message;
  }

  @override
  int get hashCode => message.hashCode;

  @override
  List<Object> get props => [message];
}
