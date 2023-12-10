import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sphincsplus_demo/business_logic.dart';
import 'package:sphincsplus_demo/presentation.dart';

class MessagePage extends StatefulWidget {
  const MessagePage({super.key});

  @override
  State<MessagePage> createState() => _MessagePageState();
}

class _MessagePageState extends State<MessagePage> {
  final textController = TextEditingController();
  @override
  void initState() {
    super.initState();
    textController.text = context.read<SignatureCubit>().state.message;
  }

  @override
  Widget build(BuildContext context) {
    return BlocListener<SignatureCubit, SignatureState>(
      listener: (context, state) {
        if (state.status.name.startsWith('message')) {
          switch (state.status) {
            case SignatureStatus.messageSetInProgress:
              context.loaderOverlay.show();
              break;
            case SignatureStatus.messageSetSuccess:
              context.loaderOverlay.hide();
              showCustomDialog(
                context,
                'MESSAGE',
                'Message set successfully',
              );
              break;
            default:
              break;
          }
        }
      },
      child: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: <Widget>[
            const Text(
              'Type the message:',
              style: TextStyle(
                color: Colors.black,
                fontSize: 18,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(height: 10),
            CustomTextField(
              maxLines: 5,
              hint: 'Message',
              borderRadius: 5,
              controller: textController,
            ),
            const Expanded(child: SizedBox()),
            Padding(
              padding: const EdgeInsets.all(20),
              child: Center(
                child: CustomButton(
                  onPressed: () {
                    context
                        .read<SignatureCubit>()
                        .setMessage(textController.text);
                  },
                  text: 'Set the message',
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
