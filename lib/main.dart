import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:scapia/bloc/data/data_cubit.dart';
import 'package:scapia/bloc/transaction/transaction_cubit.dart';
import 'package:scapia/screens/intro_page.dart';
import 'package:scapia/utils/size_constants.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (context) => DataCubit()),
        BlocProvider(
            create: (context) => TransactionCubit(
                  context.read<DataCubit>(),
                )),
      ],
      child: MaterialApp(
        title: 'Flutter Heatmap',
        theme: ThemeData(
          splashColor: Colors.transparent,
          highlightColor: Colors.transparent,
          scaffoldBackgroundColor: Colors.white,
          appBarTheme: const AppBarTheme(
            backgroundColor: Colors.white,
            // elevation: 0.0,
          ),
          useMaterial3: false,
        ),
        home: const IntroScreen(),
      ),
    );
  }
}
