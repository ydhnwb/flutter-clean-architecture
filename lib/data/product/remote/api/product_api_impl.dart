import 'package:dio/dio.dart';
import 'package:flutter_clean_architecture/data/common/response/response_wrapper.dart';
import 'package:flutter_clean_architecture/data/product/remote/api/product_api.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/create_product_request.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/product_response.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/update_product_request.dart';
import 'package:flutter_clean_architecture/domain/common/base/base_exception.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/domain/product/entity/user_product_entity.dart';

class ProductApiImpl implements ProductApi {
  final Dio dio;

  ProductApiImpl({required this.dio});

  @override
  Future<List<ProductEntity>> findAllProduct() async {
    try{
      final response = await dio.get("product/");
      var converted = WrappedListResponse<ProductResponse>.fromjson(response.data, (data) {
        List<ProductResponse> products = data.map((e) => ProductResponse.fromJson(e)).toList();
        return products;
      });

      if(response.statusCode == 200){
        var products = _mapToEntities(converted.data!);
        return products;
      }
      throw BaseException(message: converted.message, code: response.statusCode);
    }on DioError catch(e){
      throw BaseException(message: e.message, code: e.response?.statusCode);
    }on Exception catch(e){
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<ProductEntity> findProductById(String id) async {
    try{
      final response = await dio.get("product/$id");
      var converted = WrappedResponse<ProductResponse>.fromJson(response.data, (data) => ProductResponse.fromJson(data));
      if(response.statusCode == 200){
        UserProductEntity user = UserProductEntity.toEntity(converted.data!.user!);
        return ProductEntity(
          id: converted.data!.id!, 
          name: converted.data!.name!, 
          price: converted.data!.price!, 
          user: user
          );
      }else{
        throw BaseException(message: converted.message, code: response.statusCode);
      }
    }on DioError catch(e){
      throw BaseException(message: e.message, code: e.response?.statusCode);
    }on Exception catch(e){
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<ProductEntity> create(CreateProductRequest createProductRequest) async {
    try{
      final response = await dio.post("product/", data: createProductRequest.toJson());
      var converted = WrappedResponse<ProductResponse>.fromJson(response.data, (data) => ProductResponse.fromJson(data));
      if(response.statusCode == 201){
        UserProductEntity user = UserProductEntity.toEntity(converted.data!.user!);
        return ProductEntity(
          id: converted.data!.id!, 
          name: converted.data!.name!, 
          price: converted.data!.price!, 
          user: user
          );
      }else{
        throw BaseException(message: converted.message, code: response.statusCode);
      }
    }on DioError catch(e){
      throw BaseException(message: e.message, code: e.response?.statusCode);
    }on Exception catch(e){
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<void> delete(String id) async {
    try{
      final response = await dio.delete("product/$id");
      if(response.statusCode != 200){
        throw BaseException(message: response.statusMessage.toString(), code: response.statusCode);
      }
    }on DioError catch(e){
      throw BaseException(message: e.message, code: e.response?.statusCode);
    }on Exception catch(e){
      throw BaseException(message: e.toString());
    }
  }

  @override
  Future<ProductEntity> update(UpdateProductRequest updateProductRequest, String id) async {
    try{
      final response = await dio.put("product/$id", data: updateProductRequest.toJson());
      if(response.statusCode == 200){
        var converted = WrappedResponse<ProductResponse>.fromJson(response.data, (data) => ProductResponse.fromJson(data));
        UserProductEntity user = UserProductEntity.toEntity(converted.data!.user!);
        return ProductEntity(
          id: converted.data!.id!, 
          name: converted.data!.name!, 
          price: converted.data!.price!, 
          user: user
          );
      }else{
        throw BaseException(message: response.statusMessage.toString(), code: response.statusCode);
      }
    }on DioError catch(e){
      throw BaseException(message: e.message, code: e.response?.statusCode);
    }on Exception catch(e){
      throw BaseException(message: e.toString());
    }
  }

  List<ProductEntity> _mapToEntities(List<ProductResponse> products){
    var temps = <ProductEntity>[];
    products.forEach((element) {
      temps.add(ProductEntity.toEntity(element));
    });
    return temps;
  }
}