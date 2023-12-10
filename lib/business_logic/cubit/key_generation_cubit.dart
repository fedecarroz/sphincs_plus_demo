import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:sphincsplus/sphincsplus_dart.dart';


part 'key_generation_state.dart';

class KeyGenerationCubit extends Cubit<KeyGenerationState> {
  KeyGenerationCubit() : super(const KeyGenerationState());

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

  void generateKeyPair({String? seed}) async {
    emit(state.copyWith(status: KeyGenerationStatus.keyGenerationInProgress));

    try {
      final Params spxParams = Params.values.singleWhere(
        (params) =>
            params.name ==
            '${state.hashType}_${state.bitNumber}${state.methodType}',
      );
      // TODO: implement real key generation
      final publicKey = Uint8List.fromList([1, 2, 3]);
      final secretKey = Uint8List.fromList([1, 2, 3, 4, 5, 6]);

      await Future.delayed(const Duration(seconds: 2));

      emit(
        state.copyWith(
          status: KeyGenerationStatus.keyGenerationSuccess,
          spxParams: spxParams,
          publicKey: publicKey,
          secretKey: secretKey,
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
