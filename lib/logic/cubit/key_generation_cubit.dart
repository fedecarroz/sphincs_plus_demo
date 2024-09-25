import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sphincs_plus/sphincs_plus_dart.dart';
import 'package:sphincs_plus_demo/logic.dart';

part 'key_generation_state.dart';

class KeyGenerationCubit extends Cubit<KeyGenerationState> {
  final DataCubit _dataCubit;

  KeyGenerationCubit(this._dataCubit) : super(const KeyGenerationState());

  void updateHashType(String? hashType) {
    emit(state.copyWith(status: KeyGenerationStatus.updateValueInProgress));
    emit(
      state.copyWith(
        status: KeyGenerationStatus.updateValueSuccess,
        hashType: hashType,
      ),
    );
  }

  void updateBitNumber(String? bitNumber) {
    emit(state.copyWith(status: KeyGenerationStatus.updateValueInProgress));
    emit(
      state.copyWith(
        status: KeyGenerationStatus.updateValueSuccess,
        bitNumber: bitNumber,
      ),
    );
  }

  void updateMethodType(String? methodType) {
    emit(state.copyWith(status: KeyGenerationStatus.updateValueInProgress));
    emit(
      state.copyWith(
        status: KeyGenerationStatus.updateValueSuccess,
        methodType: methodType,
      ),
    );
  }

  void updateTweakableHash(Thash? thash) {
    emit(state.copyWith(status: KeyGenerationStatus.updateValueInProgress));
    emit(
      state.copyWith(
        status: KeyGenerationStatus.updateValueSuccess,
        spxThash: thash,
      ),
    );
  }

  void generateKeyPair({String? seed}) async {
    emit(state.copyWith(status: KeyGenerationStatus.keyGenerationInProgress));

    try {
      final Params spxParams = Params.values.singleWhere(
        (params) =>
            params.name ==
            '${state.hashType}_${state.bitNumber}${state.methodType}',
      );

      _dataCubit.sphincsPlus = SphincsPlus(
        params: spxParams,
        thash: state.spxThash!,
      );

      late final Uint8List publicKey;
      late final Uint8List secretKey;
      (publicKey, secretKey) = _dataCubit.sphincsPlus.generateKeyPair();

      _dataCubit.setKeyPair(publicKey, secretKey);

      emit(
        state.copyWith(
          status: KeyGenerationStatus.keyGenerationSuccess,
          spxParams: spxParams,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: KeyGenerationStatus.keyGenerationFailure));
    }
  }

  void reset() {
    emit(state.copyWith(status: KeyGenerationStatus.resetInProgress));
    emit(const KeyGenerationState(status: KeyGenerationStatus.resetSuccess));
  }
}
