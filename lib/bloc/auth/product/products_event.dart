part of 'products_bloc.dart';

abstract class ProductsEvent extends Equatable {
  const ProductsEvent();

  @override
  List<Object> get props => [];
}

class FetchProductById extends ProductsEvent {
  final int id;
  const FetchProductById({required this.id});
  @override
  List<Object> get props => [id];
}

class FetchProduct extends ProductsEvent {
  const FetchProduct();
}

class FetchAllproducts extends ProductsEvent {
  const FetchAllproducts();
}
