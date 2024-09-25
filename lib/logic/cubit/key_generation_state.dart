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
  final Thash? spxThash;
  final Params? spxParams;

  const KeyGenerationState({
    this.status = KeyGenerationStatus.initial,
    this.hashType = '',
    this.bitNumber = '',
    this.methodType = '',
    this.spxThash,
    this.spxParams,
  });

  KeyGenerationState copyWith({
    KeyGenerationStatus? status,
    String? hashType,
    String? bitNumber,
    String? methodType,
    Thash? spxThash,
    Params? spxParams,
  }) {
    return KeyGenerationState(
      status: status ?? this.status,
      hashType: hashType ?? this.hashType,
      bitNumber: bitNumber ?? this.bitNumber,
      methodType: methodType ?? this.methodType,
      spxThash: spxThash ?? this.spxThash,
      spxParams: spxParams ?? this.spxParams,
    );
  }

  @override
  List<Object?> get props => [
        status,
        hashType,
        bitNumber,
        methodType,
        spxThash,
        spxParams,
      ];
}
