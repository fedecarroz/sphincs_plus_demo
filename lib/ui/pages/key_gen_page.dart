import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sphincs_plus/sphincs_plus_dart.dart';
import 'package:sphincs_plus_demo/logic.dart';
import 'package:sphincs_plus_demo/ui/widgets.dart';

class KeyGenPage extends StatelessWidget {
  const KeyGenPage({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocConsumer<KeyGenerationCubit, KeyGenerationState>(
      listener: (context, state) {
        switch (state.status) {
          case KeyGenerationStatus.keyGenerationInProgress:
            context.loaderOverlay.show();
            break;
          case KeyGenerationStatus.keyGenerationSuccess:
            context.loaderOverlay.hide();
            showCustomDialog(
              context,
              'KEY GENERATION',
              'Key pair generated successfully',
            );
            break;
          case KeyGenerationStatus.keyGenerationFailure:
            context.loaderOverlay.hide();
            showCustomDialog(
              context,
              'ERROR',
              'Key pair generation failure!',
            );
            break;
          default:
            break;
        }
      },
      builder: (context, state) {
        return Padding(
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: <Widget>[
              const _HashSelection(),
              const SizedBox(height: 10),
              const _BitSelection(),
              const SizedBox(height: 10),
              const _MethodSelection(),
              const SizedBox(height: 10),
              const _TweakableHashSelection(),
              const Expanded(child: SizedBox()),
              Padding(
                padding: const EdgeInsets.all(20),
                child: Center(
                  child: CustomButton(
                    onPressed: () {
                      context.read<KeyGenerationCubit>().generateKeyPair();
                    },
                    text: 'Generate key pair',
                  ),
                ),
              ),
            ],
          ),
        );
      },
    );
  }
}

class _HashSelection extends StatelessWidget {
  const _HashSelection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyGenerationCubit, KeyGenerationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Hash type:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'haraka',
                  groupValue: state.hashType,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateHashType(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  'Haraka',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'sha2',
                  groupValue: state.hashType,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateHashType(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  'SHA2',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'shake',
                  groupValue: state.hashType,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateHashType(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  'SHAKE',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _BitSelection extends StatelessWidget {
  const _BitSelection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyGenerationCubit, KeyGenerationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Bit number:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: '128',
                  groupValue: state.bitNumber,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateBitNumber(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  '128',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: '192',
                  groupValue: state.bitNumber,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateBitNumber(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  '192',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: '256',
                  groupValue: state.bitNumber,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateBitNumber(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  '256',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _MethodSelection extends StatelessWidget {
  const _MethodSelection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyGenerationCubit, KeyGenerationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Method type:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 's',
                  groupValue: state.methodType,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateMethodType(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  'Slow',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<String>(
                  value: 'f',
                  groupValue: state.methodType,
                  onChanged: (String? value) {
                    context.read<KeyGenerationCubit>().updateMethodType(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  'Fast',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}

class _TweakableHashSelection extends StatelessWidget {
  const _TweakableHashSelection();

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<KeyGenerationCubit, KeyGenerationState>(
      builder: (context, state) {
        return Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Tweakable hash:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 15,
                fontWeight: FontWeight.bold,
              ),
            ),
            Row(
              children: <Widget>[
                Radio<Thash>(
                  value: Thash.simple,
                  groupValue: state.spxThash,
                  onChanged: (Thash? value) {
                    context
                        .read<KeyGenerationCubit>()
                        .updateTweakableHash(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  'Simple',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
            Row(
              children: <Widget>[
                Radio<Thash>(
                  value: Thash.robust,
                  groupValue: state.spxThash,
                  onChanged: (Thash? value) {
                    context
                        .read<KeyGenerationCubit>()
                        .updateTweakableHash(value);
                  },
                  activeColor: Colors.orange,
                ),
                const Text(
                  'Robust',
                  style: TextStyle(
                    color: Colors.black,
                    fontSize: 15,
                  ),
                ),
              ],
            ),
          ],
        );
      },
    );
  }
}
