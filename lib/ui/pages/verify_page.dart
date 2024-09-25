import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sphincs_plus_demo/logic.dart';
import 'package:sphincs_plus_demo/ui.dart';

class VerifyPage extends StatefulWidget {
  const VerifyPage({super.key});

  @override
  State<VerifyPage> createState() => _VerifyPageState();
}

class _VerifyPageState extends State<VerifyPage> {
  final textController = TextEditingController();

  @override
  void initState() {
    super.initState();
    textController.text =
        context.read<SignatureCubit>().state.tamperedMessage.toString();
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignatureCubit, SignatureState>(
      listener: _signatureListener,
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Signed message:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              maxLines: 5,
              hint: 'Signed message',
              borderRadius: 5,
              controller: textController,
            ),
            const SizedBox(height: 10),
            Row(
              children: <Widget>[
                Expanded(
                  child: CustomButton(
                    onPressed: () => context
                        .read<SignatureCubit>()
                        .tamperSignature(textController.text),
                    text: 'Tamper',
                  ),
                ),
                const SizedBox(width: 10),
                Expanded(
                  child: CustomButton(
                    onPressed: () =>
                        context.read<SignatureCubit>().restoreTamper(),
                    text: 'Reset',
                  ),
                ),
              ],
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  onPressed: () =>
                      context.read<SignatureCubit>().verifySignedMessage(),
                  text: 'Verify the signature',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  void _signatureListener(
    BuildContext context,
    SignatureState state,
  ) {
    switch (state.status) {
      case SignatureStatus.tamperInProgress:
      case SignatureStatus.restoreTamperInProgress:
      case SignatureStatus.verificationInProgress:
        context.loaderOverlay.show();
        break;
      case SignatureStatus.verificationSuccess:
        context.loaderOverlay.hide();
        final result = state.verified ? 'successful' : 'failed';
        showCustomDialog(
          context,
          'VERIFICATION',
          'Signature verification $result',
        );
        break;
      case SignatureStatus.verificationFailure:
        context.loaderOverlay.hide();
        showCustomDialog(
          context,
          'VERIFICATION',
          'Error during the verification',
        );
        break;
      case SignatureStatus.tamperSuccess:
        context.loaderOverlay.hide();
        showCustomDialog(
          context,
          'TAMPERING',
          'Message tampered successfully',
        );
        break;
      case SignatureStatus.restoreTamperSuccess:
        context.loaderOverlay.hide();
        textController.text = state.tamperedMessage.toString();
        showCustomDialog(
          context,
          'TAMPERING',
          'Original message restored',
        );
        break;
      default:
        break;
    }
  }
}
