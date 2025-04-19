import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../../common/widgets/appbar/appbar.dart';
import '../../../../common/widgets/custom_shapes/containers/search_container.dart';
import '../../../../common/widgets/layouts/grid_layout.dart';
import '../../../../common/widgets/products/product_cards/product_card_vertical.dart';
import '../../../../core/constants/sizes.dart';
import '../../../../core/helpers/home_cubit/home_cubit.dart';
import '../../../../core/models/product_model.dart';

class SearchViewBody extends StatefulWidget {
  const SearchViewBody({super.key});

  @override
  State<SearchViewBody> createState() => _SearchViewBodyState();
}

class _SearchViewBodyState extends State<SearchViewBody> {
  final TextEditingController _searchController = TextEditingController();

  @override
  void dispose() {
    _searchController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final homeCubit = context.read<HomeCubit>();
    return Scaffold(
      body: ListView(
        children: [
          const TAppBar(
            showBackArrow: true,
            title: Text('Search Results'),
          ),
          const SizedBox(height: TSizes.spaceBtwItems),

          /// Search Field
          TSearchContainer(
            text: "Search in Store",
            enableTextField: true,
            controller: _searchController,
            query: _searchController.text,
            onChanged: (value) {
              homeCubit.search(value);
            },
          ),

          /// Results Section
          Padding(
            padding: const EdgeInsets.all(TSizes.defaultSpace),
            child: BlocBuilder<HomeCubit, HomeState>(
              builder: (context, state) {
                HomeCubit homeCubit = context.read<HomeCubit>();
                List<ProductModel> products =
                    context.read<HomeCubit>().products;
                final results = homeCubit.searchResults;
                final isSearching = homeCubit.isSearching;

                if (state is GetDataLoading) {
                  return const Center(child: CircularProgressIndicator());
                }

                if (isSearching && results.isEmpty) {
                  return const Center(child: Text("There are no results"));
                }

                return TGridLayout(
                  itemCount: results.length,
                  itemBuilder: (_, index) => TProductCardVertical(
                    isFavorite:
                        homeCubit.checkIsFavorite(products[index].productId!),
                    onPressed: () {
                      homeCubit.addToFavorite(products[index].productId!);
                    },
                    productModel: results[index],
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
