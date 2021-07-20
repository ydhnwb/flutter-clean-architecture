import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/update_product_request.dart';
import 'package:flutter_clean_architecture/domain/product/repository/get_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/repository/update_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/delete_product_usecase.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/find_product_by_id_usecase.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/update_product_usecase.dart';
import 'package:flutter_clean_architecture/presentation/detail/bloc/detail_product_event.dart';
import 'package:flutter_clean_architecture/presentation/detail/bloc/detail_product_state.dart';

class DetailProductPageBloc extends Bloc<DetailProductPageEvent, DetailProductPageState>{
  final FindProductByIdUseCase findProductByIdUseCase;
  final UpdateProductUseCase updateProductUseCase;
  final DeleteProductUseCase deleteProductUseCase;
  DetailProductPageBloc({
    required this.findProductByIdUseCase, 
    required this.updateProductUseCase,
    required this.deleteProductUseCase
  }) : super(DetailProductPageStateInit());

  
  @override
  Stream<DetailProductPageState> mapEventToState(DetailProductPageEvent event) async*{
    if(event is DetailProductPageEventFindProductById){
      yield* _findById(event.id);
    }else if(event is DetailProductPageEventUpdateProduct){
      yield* _updateProduct(event.updateProductRequest, event.id);
    }else if(event is DetailProductPageEvenetDeleteById){
      yield* _deleteProduct(event.id);
    }
  }

  Stream<DetailProductPageState> _setIsLoading(bool isLoading) async* {
    yield DetailProductPageStateIsLoading(isLoading: isLoading);
  }

  Stream<DetailProductPageState> _updateProduct(UpdateProductRequest req, String id) async* {
    yield* _setIsLoading(true);
    final result = await updateProductUseCase.invoke(req, id);
    yield* _setIsLoading(false);
    yield* result.fold(
      (l) async* {
        yield DetailProductPageStateSuccessUpdate();
      }, 
      (r) async* {
        String msg = "${r.message} [${r.code}]";
        yield DetailProductPageStateShowMessage(message: msg);
      }
    );
  }

  Stream<DetailProductPageState> _deleteProduct(String id) async* {
    yield* _setIsLoading(true);
    final result = await deleteProductUseCase.invoke(id);
    yield* _setIsLoading(false);
    yield* result.fold(
      (l) async* {
        // using the same state for now, since it is just popping
        yield DetailProductPageStateSuccessUpdate();
      }, 
      (r) async* {
        String msg = "${r.message} [${r.code}]";
        yield DetailProductPageStateShowMessage(message: msg);
      }
    );
  }

  Stream<DetailProductPageState> _findById(String id) async* {
    yield* _setIsLoading(true);
    final result = await findProductByIdUseCase.invoke(id);
    yield* _setIsLoading(false);
    yield* result.fold(
      (l) async* {
        yield DetailProductPageStateReceiveProduct(productEntity: l);
      }, 
      (r) async* {
        String msg = "${r.message} [${r.code}]";
        yield DetailProductPageStateShowMessage(message: msg);
      }
    );
  }

}