import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../domain/repositories/product_repo.dart';
import '../data_sources/product_data_source.dart';
import '../data_sources/product_remote_data_source.dart';

class ProductRepositoryImp implements ProductRepository {
  ProductRemoteDataSource productRemoteDataSource;

  ProductRepositoryImp({required this.productRemoteDataSource});

  @override
  Future<Either<Failure, ResponseProductEntity>> getAllProduct() {
    return productRemoteDataSource.getAllProduct();
  }
}

ProductRepository injectProductRepository() {
  return ProductRepositoryImp(
    productRemoteDataSource: injectProductRemoteDataSource(),
  );
}
