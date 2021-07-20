import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_clean_architecture/domain/product/entity/product_entity.dart';
import 'package:flutter_clean_architecture/domain/product/repository/get_product_repository.dart';
import 'package:flutter_clean_architecture/domain/product/usecase/find_all_product_usecase.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/bloc/primary_tab_event.dart';
import 'package:flutter_clean_architecture/presentation/home/primary/bloc/primary_tab_state.dart';

class PrimaryTabBloc extends Bloc<PrimaryTabEvent, PrimaryTabState> {
  final FindAllProductUseCase findAllProductUseCase;

  PrimaryTabBloc({required this.findAllProductUseCase}) : super(PrimaryTabStateInit());

  @override
  Stream<PrimaryTabState> mapEventToState(PrimaryTabEvent event) async* {
    if(event is PrimaryTabEventGetProducts){
      yield* _getAllProduct();
    }
  }

  Stream<PrimaryTabState> _setLoading(bool b) async* {
    yield PrimaryTabStateLoading(isLoading: b);
  }


  Stream<PrimaryTabState> _getAllProduct() async* {
    try{
      yield* _setLoading(true);
      var result = await findAllProductUseCase.invoke();
      yield* _setLoading(false);
      yield* result.fold(
        (l) async* {
          final temps = <ProductEntity>[];
          temps.addAll(l);
          yield PrimaryTabStateProducts(products: temps);
        }, 
        (r) async* {
          String message = "${r.message} [${r.code}]";
          yield PrimaryTabStateShowMessage(message: message);
        }
      );
    }on Exception catch(e){
      yield PrimaryTabStateShowMessage(message: e.toString());
    }
  }

}