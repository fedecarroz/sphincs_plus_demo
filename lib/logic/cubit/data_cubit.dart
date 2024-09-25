import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sphincs_plus/sphincs_plus_dart.dart';

part 'data_state.dart';

class DataCubit extends Cubit<DataState> {
  DataCubit()
      : super(
          DataState(
            sphincsPlus: SphincsPlus(),
            publicKey: Uint8List(0),
            secretKey: Uint8List(0),
          ),
        );

  SphincsPlus get sphincsPlus => state.sphincsPlus;

  Uint8List get publicKey => state.publicKey;

  Uint8List get secretKey => state.secretKey;

  set sphincsPlus(SphincsPlus sphincsPlus) {
    emit(
      state.copyWith(
        status: DataStatus.signerInitSuccess,
        sphincsPlus: sphincsPlus,
      ),
    );
  }

  void setKeyPair(Uint8List publicKey, Uint8List secretKey) {
    emit(
      state.copyWith(
        status: DataStatus.keyPairInitSuccess,
        publicKey: publicKey,
        secretKey: secretKey,
      ),
    );
  }
}
