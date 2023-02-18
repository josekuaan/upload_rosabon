part of 'products_bloc.dart';

abstract class ProductsState extends Equatable {
  const ProductsState();

  @override
  List<Object> get props => [];
}

class ProductsInitial extends ProductsState {}

class FetchingProduct extends ProductsState {}

class ProductCategorySuccessful extends ProductsState {
  final ProductCategoryResponse productCategoryResponse;
  const ProductCategorySuccessful({required this.productCategoryResponse});
  @override
  List<Object> get props => [productCategoryResponse];
}

class ProductSuccessful extends ProductsState {
  final ProductResponse productResponse;
  const ProductSuccessful({required this.productResponse});
  @override
  List<Object> get props => [productResponse];
}

class SingleProduct extends ProductsState {
  final Item item;
  const SingleProduct({required this.item});
  @override
  List<Object> get props => [item];
}

class ProductError extends ProductsState {
  final String error;
  const ProductError({required this.error});
  @override
  List<Object> get props => [error];
}
