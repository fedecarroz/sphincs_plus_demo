import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loader_overlay/loader_overlay.dart';
import 'package:sphincs_plus_demo/logic.dart';
import 'package:sphincs_plus_demo/ui.dart';

void main() {
  Bloc.observer = DebugBloc();
  WidgetsBinding widgetsBinding = WidgetsFlutterBinding.ensureInitialized();
  // ignore: deprecated_member_use
  widgetsBinding.renderView.automaticSystemUiAdjustment = false;
  SystemChrome.setSystemUIOverlayStyle(SystemUiOverlayStyle.light);
  runApp(App());
}

class App extends StatelessWidget {
  final dataCubit = DataCubit();

  App({super.key});

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: <BlocProvider>[
        BlocProvider<DataCubit>.value(
          value: dataCubit,
        ),
        BlocProvider<KeyGenerationCubit>(
          create: (context) => KeyGenerationCubit(dataCubit),
        ),
        BlocProvider<SignatureCubit>(
          create: (context) => SignatureCubit(dataCubit),
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
