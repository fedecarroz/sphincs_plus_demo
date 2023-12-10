part of 'key_generation_cubit.dart';

enum KeyGenerationStatus {
  initial,
  updateValueInProgress,
  updateValueSuccess,
  keyGenerationInProgress,
  keyGenerationSuccess,
  keyGenerationFailure,
  resetInProgress,
  resetSuccess,
}

class KeyGenerationState extends Equatable {
  final KeyGenerationStatus status;
  final String hashType;
  final String bitNumber;
  final String methodType;
  final Params? spxParams;
  final Uint8List? publicKey;
  final Uint8List? secretKey;

  const KeyGenerationState({
    this.status = KeyGenerationStatus.initial,
    this.hashType = '',
    this.bitNumber = '',
    this.methodType = '',
    this.spxParams,
    this.publicKey,
    this.secretKey,
  });

  KeyGenerationState copyWith({
    KeyGenerationStatus? status,
    String? hashType,
    String? bitNumber,
    String? methodType,
    Params? spxParams,
    Uint8List? publicKey,
    Uint8List? secretKey,
  }) {
    return KeyGenerationState(
      status: status ?? this.status,
      hashType: hashType ?? this.hashType,
      bitNumber: bitNumber ?? this.bitNumber,
      methodType: methodType ?? this.methodType,
      spxParams: spxParams ?? this.spxParams,
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
    );
  }

  @override
  List<Object?> get props => [
        status,
        hashType,
        bitNumber,
        methodType,
        spxParams,
        publicKey,
        secretKey,
      ];
}
