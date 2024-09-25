part of 'signature_cubit.dart';

enum SignatureStatus {
  initial,
  messageSetInProgress,
  messageSetSuccess,
  signatureInProgress,
  signatureSuccess,
  signatureFailure,
  tamperInProgress,
  tamperSuccess,
  verificationInProgress,
  verificationSuccess,
  verificationFailure,
  restoreTamperInProgress,
  restoreTamperSuccess,
  resetInProgress,
  resetSuccess,
}

class SignatureState extends Equatable {
  final SignatureStatus status;
  final String message;
  final Uint8List? signedMessage;
  final Uint8List? tamperedMessage;
  final bool verified;

  const SignatureState({
    this.status = SignatureStatus.initial,
    this.message = '',
    this.signedMessage,
    this.tamperedMessage,
    this.verified = false,
  });

  SignatureState copyWith({
    SignatureStatus? status,
    String? message,
    Uint8List? signedMessage,
    Uint8List? tamperedMessage,
    bool? verified,
  }) {
    return SignatureState(
      status: status ?? this.status,
      message: message ?? this.message,
      signedMessage: signedMessage ?? this.signedMessage,
      tamperedMessage: tamperedMessage ?? this.tamperedMessage,
      verified: verified ?? this.verified,
    );
  }

  @override
  List<Object?> get props => [
        status,
        message,
        signedMessage,
        tamperedMessage,
        verified,
      ];
}
