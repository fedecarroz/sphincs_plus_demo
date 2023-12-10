import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:sphincsplus_demo/business_logic.dart';
import 'package:sphincsplus_demo/presentation.dart';

class HomePage extends StatefulWidget {
  const HomePage({super.key});

  @override
  State<HomePage> createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  int _selectedIndex = 0;
  final _pageController = PageController();

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        leading: IconButton(
          onPressed: () {
            showCustomDialog(
              context,
              'INFO',
              'SPHINCS+ Demo\n'
                  'credits to:\n'
                  'Federico Carrozzino\n'
                  'Marco Franceschini',
              height: 245,
            );
          },
          icon: const Icon(
            Icons.info_outline,
            color: Colors.white,
          ),
        ),
        title: const Text(
          'SPHINCS+ Demo',
          style: TextStyle(color: Colors.white),
        ),
        actions: <Widget>[
          IconButton(
            onPressed: () {
              context
                ..read<KeyGenerationCubit>().reset()
                ..read<SignatureCubit>().reset();
              showCustomDialog(
                context,
                'RESET',
                'Reset successful',
              ).then(
                (_) {
                  setState(() => _selectedIndex = 0);
                  _pageController.animateToPage(
                    0,
                    duration: const Duration(milliseconds: 200),
                    curve: Curves.linear,
                  );
                },
              );
            },
            icon: const Icon(
              Icons.close,
              color: Colors.white,
            ),
          ),
        ],
      ),
      body: SafeArea(
        child: PageView(
          physics: const NeverScrollableScrollPhysics(),
          controller: _pageController,
          children: const <Widget>[
            KeyGenPage(),
            MessagePage(),
            SignPage(),
            VerifyPage(),
          ],
        ),
      ),
      bottomNavigationBar: CustomBottomNavbar(
        currentIndex: _selectedIndex,
        onTap: (index) {
          setState(() => _selectedIndex = index);
          _pageController.animateToPage(
            index,
            duration: const Duration(milliseconds: 200),
            curve: Curves.linear,
          );
        },
      ),
    );
  }
}
