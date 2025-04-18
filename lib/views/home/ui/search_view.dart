import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:nine_aki_bro/core/helpers/home_cubit/home_cubit.dart';
import 'package:nine_aki_bro/views/home/ui/widgets/search_view_body.dart';

class SearchView extends StatelessWidget {
  const SearchView({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocProvider(
      create: (_) => HomeCubit()..getProducts(),
      child: const SearchViewBody(),
    );
  }
}

