import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:rosabon/model/response_models/product_category_response.dart';
import 'package:rosabon/model/response_models/product_response.dart';
import 'package:rosabon/repository/product_repository.dart';

part 'products_event.dart';
part 'products_state.dart';

class ProductsBloc extends Bloc<ProductsEvent, ProductsState> {
  final ProductRepository productRepository = ProductRepository();
  ProductsBloc() : super(ProductsInitial()) {
    on<ProductsEvent>((event, emit) async {
      if (event is FetchProductById) {
        await getProductById(event, emit);
      }
      if (event is FetchProduct) {
        await getProducts(event, emit);
      }
      if (event is FetchAllproducts) {
        await allproducts(event, emit);
      }
    });
  }

  Future<void> getProductById(
      FetchProductById event, Emitter<ProductsState> emit) async {
    try {
      emit(FetchingProduct());
      var res = await productRepository.getProductById(event.id);

      emit(SingleProduct(item: res));
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }

  Future<void> getProducts(
      FetchProduct event, Emitter<ProductsState> emit) async {
    try {
      emit(FetchingProduct());
      var res = await productRepository.getProducts();

      emit(ProductCategorySuccessful(productCategoryResponse: res));
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }

  Future<void> allproducts(
      FetchAllproducts event, Emitter<ProductsState> emit) async {
    try {
      emit(FetchingProduct());

      var res = await productRepository.allproducts();

      emit(ProductSuccessful(productResponse: res));
    } catch (e) {
      emit(ProductError(error: e.toString()));
    }
  }
}
