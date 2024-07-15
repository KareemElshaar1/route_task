import 'package:dartz/dartz.dart';
import 'package:route_task/route_task/data/data_sources/product_remote_data_source.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';
import '../../presentation/manager/api_manager.dart';

class ProductRemoteDataSourceImp implements ProductRemoteDataSource {
  ApiManager apiManager;

  ProductRemoteDataSourceImp({required this.apiManager});

  @override
  Future<Either<Failure, ResponseProductEntity>> getAllProduct() async {
    var either = await apiManager.getAllProduct();
    return either.fold(
      (l) => Left(
        Failure(errorMessage: l?.errorMessage),
      ),
      (response) => Right(
        response,
      ),
    );
  }
}

ProductRemoteDataSource injectProductRemoteDataSource() {
  return ProductRemoteDataSourceImp(apiManager: ApiManager.instance);
}
