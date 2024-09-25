import 'package:flutter/material.dart';
import 'package:sphincs_plus_demo/ui.dart';

Future<void> showCustomDialog(
  BuildContext context,
  String title,
  String text, {
  void Function()? onTap,
  double height = 195,
}) async {
  return showDialog(
    context: context,
    builder: (context) => _CustomDialog(
      title,
      text,
      height,
    ),
  );
}

class _CustomDialog extends StatelessWidget {
  final String title;
  final String text;
  final double height;

  const _CustomDialog(
    this.title,
    this.text,
    this.height,
  );

  @override
  Widget build(BuildContext context) {
    return DefaultTextStyle(
      style: const TextStyle(),
      child: Center(
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(10),
            color: Colors.white,
          ),
          height: height,
          width: MediaQuery.of(context).size.width * 0.75,
          child: Column(
            children: <Widget>[
              Container(
                decoration: const BoxDecoration(
                  borderRadius: BorderRadius.vertical(
                    top: Radius.circular(10),
                  ),
                  color: Colors.orange,
                ),
                width: double.maxFinite,
                height: 50,
                alignment: Alignment.center,
                child: Container(
                  margin: const EdgeInsets.symmetric(
                    horizontal: 20,
                  ),
                  child: Text(
                    title.toUpperCase(),
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ),
              Expanded(
                child: Center(
                  child: Container(
                    margin: const EdgeInsets.all(20),
                    child: Column(
                      children: <Widget>[
                        Text(
                          text,
                          style: const TextStyle(
                            color: Colors.black,
                            fontSize: 15,
                          ),
                          textAlign: TextAlign.center,
                        ),
                        const SizedBox(height: 30),
                        CustomButton(
                          onPressed: () => Navigator.of(context).pop(),
                          text: 'OK',
                        ),
                      ],
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
