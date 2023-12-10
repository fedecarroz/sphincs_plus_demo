import 'dart:convert';
import 'dart:typed_data';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';

part 'signature_state.dart';

class SignatureCubit extends Cubit<SignatureState> {
  SignatureCubit() : super(const SignatureState());

  void setMessage(String message) {
    emit(state.copyWith(status: SignatureStatus.messageSetInProgress));
    emit(
      state.copyWith(
        status: SignatureStatus.messageSetSuccess,
        message: message,
      ),
    );
  }

  void signMessage() {
    emit(state.copyWith(status: SignatureStatus.signatureInProgress));
    try {
      // TODO: implement real signature
      final signedMessage = Uint8List.fromList([1, 2, 3]);

      emit(
        state.copyWith(
          status: SignatureStatus.signatureSuccess,
          signedMessage: signedMessage,
          tamperedMessage: signedMessage,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: SignatureStatus.signatureFailure));
    }
  }

  void tamperSignature(String value) {
    emit(state.copyWith(status: SignatureStatus.tamperInProgress));
    final dynamicList = jsonDecode(value);
    final parsedList = List<int>.from(dynamicList);
    final tamperedMessage = Uint8List.fromList(parsedList);

    emit(
      state.copyWith(
        status: SignatureStatus.tamperSuccess,
        tamperedMessage: tamperedMessage,
        verified: false,
      ),
    );
  }

  void restoreTamper() {
    emit(state.copyWith(status: SignatureStatus.restoreTamperInProgress));

    emit(
      state.copyWith(
        status: SignatureStatus.restoreTamperSuccess,
        tamperedMessage: state.signedMessage,
      ),
    );
  }

  void verifySignedMessage() {
    emit(state.copyWith(status: SignatureStatus.verificationInProgress));

    try {
      // TODO: implement real verification
      final result = state.tamperedMessage == state.signedMessage;

      emit(
        state.copyWith(
          status: SignatureStatus.verificationSuccess,
          verified: result,
        ),
      );
    } catch (e) {
      emit(state.copyWith(status: SignatureStatus.verificationFailure));
    }
  }

  void reset() {
    emit(state.copyWith(status: SignatureStatus.resetInProgress));
    emit(const SignatureState(status: SignatureStatus.resetSuccess));
  }
}
