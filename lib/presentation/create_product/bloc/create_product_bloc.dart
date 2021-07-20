import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/data/product/remote/dto/create_product_request.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/create_product_usecase.dart';
import 'package:flutter_clean_architecture/presentation/create_product/bloc/create_product_event.dart';
import 'package:flutter_clean_architecture/presentation/create_product/bloc/create_product_state.dart';

class CreateProductPageBloc extends Bloc<CreateProductPageEvent, CreateProductPageState>{
  final CreateProductUseCase createProductUseCase;

  CreateProductPageBloc({required this.createProductUseCase}) : super(CreateProductPageStateInit());

  @override
  Stream<CreateProductPageState> mapEventToState(CreateProductPageEvent event) async*{
    if(event is CreateProductPageEventCreateProduct){
      yield* _create(event.createProductRequest);
    }
  }

  Stream<CreateProductPageState> _setIsLoading(bool isLoading) async* {
    yield CreateProductPageStateIsLoading(isLoading: isLoading);
  }

  Stream<CreateProductPageState> _create(CreateProductRequest req) async* {
    yield* _setIsLoading(true);
    final result = await createProductUseCase.invoke(req);
    yield* _setIsLoading(false);
    yield* result.fold(
      (l) async* {
        yield CreateProductPageStateSuccessCreate();
      }, 
      (r) async* {
        String msg = "${r.message} [${r.code}]";
        yield CreateProductPageStateShowMessage(message: msg);
      }
    );
  }
}