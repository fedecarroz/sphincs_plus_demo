part of 'data_cubit.dart';

enum DataStatus {
  initial,
  signerInitSuccess,
  keyPairInitSuccess,
}

class DataState extends Equatable {
  final DataStatus status;
  final SphincsPlus sphincsPlus;
  final Uint8List publicKey;
  final Uint8List secretKey;

  const DataState({
    this.status = DataStatus.initial,
    required this.sphincsPlus,
    required this.publicKey,
    required this.secretKey,
  });

  DataState copyWith({
    DataStatus? status,
    SphincsPlus? sphincsPlus,
    Uint8List? publicKey,
    Uint8List? secretKey,
  }) {
    return DataState(
      status: status ?? this.status,
      sphincsPlus: sphincsPlus ?? this.sphincsPlus,
      publicKey: publicKey ?? this.publicKey,
      secretKey: secretKey ?? this.secretKey,
    );
  }

  @override
  List<Object?> get props => [status, sphincsPlus, publicKey, secretKey];
}
