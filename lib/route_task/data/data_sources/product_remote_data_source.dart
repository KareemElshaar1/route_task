import 'package:dartz/dartz.dart';

import '../../../core/error/failures.dart';
import '../../domain/entities/product_entity.dart';

abstract class ProductRemoteDataSource {
  Future<Either<Failure, ResponseProductEntity>> getAllProduct();
}
