import 'package:cmed_app/Models/modelClass.dart';
import 'package:cmed_app/Models/modelClassDietas.dart';
import 'package:cmed_app/Models/modelClassMedica.dart';
import 'package:cmed_app/Models/modelClassRecetaM.dart';
import 'package:get_it/get_it.dart';

final GetIt getIt = GetIt.instance;

 setUp() async {

  getIt.registerLazySingleton<modelClass>(() =>  modelClass());
  getIt.registerLazySingleton<modelClassMedica>(() => modelClassMedica());
  getIt.registerLazySingleton<modelClassDieta>(() => modelClassDieta());
  getIt.registerLazySingleton<modelClassReceta>(() => modelClassReceta());
  
}