abstract class ProductApi {
  Future<List<ProductEntity>> findAllProduct();
  Future<ProductEntity> findProductById(String id);
}