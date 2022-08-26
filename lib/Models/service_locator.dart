import 'package:cmed_app/Models/modelClass.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

void setUp() {

  getIt.registerLazySingleton(() =>  modelClass());

}