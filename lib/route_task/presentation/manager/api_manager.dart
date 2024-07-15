import 'dart:convert';

import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:dartz/dartz.dart';
import 'package:http/http.dart' as http;

import '../../../core/error/failures.dart';
import '../../../core/utils/api_constant.dart';
import '../../data/models/product_response_model.dart';

class ApiManager {
  ApiManager._();

  static ApiManager? _instance;

  static ApiManager get instance {
    _instance ??= ApiManager._();
    return _instance!;
  }

  Future<Either<Failure, ResponseProductDto>> getAllProduct() async {
    final List<ConnectivityResult> connectivityResult =
        await (Connectivity().checkConnectivity());

    if (connectivityResult.contains(ConnectivityResult.mobile) ||
        connectivityResult.contains(ConnectivityResult.wifi)) {
      //? connected internet
      Uri url = Uri.https(apiBaseUrl, apiGetProducts);
      var response = await http.get(url);

      var getAllProductResponse =
          ResponseProductDto.fromJson(jsonDecode(response.body));

      if (response.statusCode >= 200 && response.statusCode < 300) {
        //? success get data
        return Right(getAllProductResponse);
      } else {
        return Left(
          ServerFailure(
              errorMessage: 'Error in response data please try again'),
        );
      }
    } else {
      return Left(
        ServerFailure(errorMessage: 'No Internet Connection please try again'),
      );
    }
  }
}
