import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../bloc/product_bloc.dart';
import '../bloc/product_event.dart';
import '../bloc/product_state.dart';
import '../pages/product_detail_page.dart';

class ProductView extends StatefulWidget {
  const ProductView({super.key});

  @override
  _ProductViewState createState() => _ProductViewState();
}

class _ProductViewState extends State<ProductView> {
  final ScrollController _scrollController = ScrollController();
  final TextEditingController _searchController = TextEditingController();
  int _currentPage = 1;

  @override
  void initState() {
    super.initState();
    _scrollController.addListener(_onScroll);
    _loadInitialProducts();
  }

  void _loadInitialProducts() {
    _currentPage = 1;
    context.read<ProductBloc>().add(FetchProducts(_currentPage));
  }

  void _onScroll() {
    if (_isBottom && !(context.read<ProductBloc>().state is ProductLoading)) {
      _currentPage++;
      context.read<ProductBloc>().add(FetchProducts(_currentPage));
    }
  }

  bool get _isBottom {
    if (!_scrollController.hasClients) return false;
    final maxScroll = _scrollController.position.maxScrollExtent;
    final currentScroll = _scrollController.position.pixels;
    return currentScroll >= (maxScroll * 0.9);
  }

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.all(8.0),
          child: TextField(
            controller: _searchController,
            decoration: const InputDecoration(
              hintText: 'Search Product...',
              border: OutlineInputBorder(),
              filled: true,
              fillColor: Colors.white,
            ),
            onChanged: (query) {
              if (query.isNotEmpty) {
                context.read<ProductBloc>().add(SearchProductsEvent(query));
              } else {
                _loadInitialProducts();
              }
            },
          ),
        ),
        Expanded(
          child: BlocBuilder<ProductBloc, ProductState>(
            builder: (context, state) {
              if (state is ProductLoading && _currentPage == 1) {
                return const Center(child: CircularProgressIndicator());
              } else if (state is ProductLoaded) {
                return ListView.builder(
                  controller: _scrollController,
                  itemCount: state.hasReachedMax ? state.products.length : state.products.length + 1,
                  itemBuilder: (context, index) {
                    if (index >= state.products.length) {
                      return const Center(child: CircularProgressIndicator());
                    }
                    final product = state.products[index];
                    return ListTile(
                      title: Text(product.name),
                      subtitle: Text(product.category),
                      trailing: Text('\$${product.price}'),
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => ProductDetailPage(product: product),
                          ),
                        );
                      },
                    );
                  },
                );
              } else if (state is ProductError) {
                return Center(child: Text('Failed to fetch products: ${state.message}'));
              } else if (state is ProductCreated) {
                return Center(child: Text('Product Created: ${state.product.name}'));
              }
              return const Center(child: Text('No products available.'));
            },
          ),
        ),
      ],
    );
  }

  @override
  void dispose() {
    _scrollController.dispose();
    _searchController.dispose();
    super.dispose();
  }
}
