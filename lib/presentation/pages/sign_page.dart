import 'dart:convert';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sphincsplus_demo/business_logic.dart';
import 'package:sphincsplus_demo/presentation.dart';

class SignPage extends StatefulWidget {
  const SignPage({super.key});

  @override
  State<SignPage> createState() => _SignPageState();
}

class _SignPageState extends State<SignPage> {
  final messageTextController = TextEditingController();
  final signedMessageTextController = TextEditingController();

  @override
  void initState() {
    super.initState();
    final signatureState = context.read<SignatureCubit>().state;
    messageTextController.text = utf8.encode(signatureState.message).toString();
    signedMessageTextController.text =
        signatureState.signedMessage?.toString() ?? '';
  }

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(20),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: <Widget>[
          const Text(
            'Message (in bytes):',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<SignatureCubit, SignatureState>(
            builder: (context, state) {
              return _MessageBox(
                message: state.message.isNotEmpty
                    ? utf8.encode(state.message).toString()
                    : '',
              );
            },
          ),
          const SizedBox(height: 10),
          const Text(
            'Signed message (in bytes):',
            style: TextStyle(
              color: Colors.black,
              fontSize: 18,
              fontWeight: FontWeight.bold,
            ),
          ),
          const SizedBox(height: 10),
          BlocBuilder<SignatureCubit, SignatureState>(
            builder: (context, state) {
              return _MessageBox(
                message: state.signedMessage?.toString() ?? '',
              );
            },
          ),
          const Expanded(child: SizedBox()),
          Padding(
            padding: const EdgeInsets.all(20),
            child: Center(
              child: CustomButton(
                onPressed: () {
                  context.read<SignatureCubit>().signMessage();
                },
                text: 'Sign the message',
              ),
            ),
          ),
        ],
      ),
    );
  }
}

class _MessageBox extends StatelessWidget {
  final String message;

  const _MessageBox({required this.message});

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        border: Border.all(
          color: Colors.grey,
        ),
        color: Colors.white,
        borderRadius: BorderRadius.circular(5),
      ),
      width: double.maxFinite,
      height: 160,
      padding: const EdgeInsets.all(12),
      child: SingleChildScrollView(
        child: Text(
          message,
          style: const TextStyle(
            color: Colors.black,
            fontSize: 18,
          ),
        ),
      ),
    );
  }
}
