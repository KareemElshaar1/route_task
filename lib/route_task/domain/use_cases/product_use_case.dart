import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../data/repositories/product_repo.dart';
import '../entities/product_entity.dart';
import '../repositories/product_repo.dart';

class GetAllProductUseCase {
  final ProductRepository productRepository;

  GetAllProductUseCase({required this.productRepository});

  Future<Either<Failure, ResponseProductEntity>> invoke() async {
    return productRepository.getAllProduct();
  }
}

GetAllProductUseCase injectGetAllProductUseCase() {
  return GetAllProductUseCase(productRepository: injectProductRepository());
}
