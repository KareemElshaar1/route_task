import 'package:flutter/cupertino.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../../domain/entities/product_entity.dart';
import '../../domain/use_cases/product_use_case.dart';

part 'products_view_model_state.dart';

class ProductsViewModelCubit extends Cubit<ProductsViewModelState> {
  ProductsViewModelCubit({required this.getAllProductUseCase})
      : super(ProductsViewModelInitial());
  GetAllProductUseCase getAllProductUseCase;
  var searchController = TextEditingController();
  List<ProductsEntity> productsList = [];
  List<ProductsEntity> productsListSearch = [];

  //? function get all Product
  void getProducts() async {
    emit(ProductsViewModelLoading());
    var either = await getAllProductUseCase.invoke();
    either.fold(
      (failure) {
        emit(ProductsViewModelError(error: failure.errorMessage));
      },
      (response) {
        productsList = response.products ?? [];
        emit(ProductsViewModelSuccess(productsList: response.products ?? []));
      },
    );
  }

  //? function search
  void searchTextInList(String text) {
    productsListSearch = productsList.where((product) {
      return product.title!.toLowerCase().contains(text.toLowerCase());
    }).toList();
    emit(SearchViewModelSuccess(productDataEntity: productsListSearch));
  }
}
