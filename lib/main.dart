import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sphincsplus_demo/business_logic.dart';
import 'package:sphincsplus_demo/presentation.dart';

void main() {
  Bloc.observer = DebugBloc();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  widgetsBinding.renderView.automaticSystemUiAdjustment = false;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(const App());
}

class App extends StatelessWidget {
  const App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<KeyGenerationCubit>(
          create: (context) => KeyGenerationCubit(),
        ),
        BlocProvider<SignatureCubit>(
          create: (context) => SignatureCubit(),
        ),
      ],
      child: MaterialApp(
        title: 'SPHINCS+ Demo',
        theme: ThemeData(
          colorScheme: ColorScheme.fromSeed(
            seedColor: Colors.orange,
          ),
          useMaterial3: true,
        ),
        home: LoaderOverlay(
          useDefaultLoading: false,
          overlayWidgetBuilder: (_) => const Center(
            child: CircularProgressIndicator(
              color: Colors.orange,
            ),
          ),
          child: const HomePage(),
        ),
        debugShowCheckedModeBanner: false,
      ),
    );
  }
}
