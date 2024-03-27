import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../../di/locator.dart';
import '../bloc/all_poducts_cubit/all_products_cubit.dart';
import '../products_argument.dart';
import '../widgets/products_grid.dart';

class AllProductsScreen extends StatelessWidget {
  static const routeName = '/all_product_screen';

  const AllProductsScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    /// get categoryId
    final arg = ModalRoute.of(context)!.settings.arguments as ProductsArguments;

    return MultiBlocProvider(
      providers: [
        BlocProvider(create: (_) => AllProductsCubit(locator())),
        // BlocProvider(create: (_) =>  FilterCubit()),
      ],
      child: Scaffold(
        appBar: AppBar(
          iconTheme: const IconThemeData(color: Colors.black),
          backgroundColor: Colors.white,
          centerTitle: true,
          title: const Text(
            'محصولات',
            style: TextStyle(color: Colors.black),
          ),
        ),
        body: ProductsGrid(
          categoryId: arg.categoryId,
          searchText: arg.searchTxt,
          sellerId: arg.sellerId,
        ),
      ),
    );
  }
}
