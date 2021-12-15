import 'dart:io';

import 'package:built_redux/built_redux.dart' as built_redux;
import 'package:dio/dio.dart';
import 'package:flutter_sample_redux/counter/model/counter_state.dart';
import 'package:flutter_sample_redux/counter/redux/store.dart';
import 'package:flutter_sample_redux/gallery/constants/api_constants.dart';
import 'package:flutter_sample_redux/gallery/redux/actions/actions_build.dart';
import 'package:flutter_sample_redux/gallery/redux/model/type_photo_generic.dart';
import 'package:flutter_sample_redux/gallery/redux/state/gallery_state.dart';
import 'package:flutter_sample_redux/gallery/redux/state/gallery_state_built.dart';
import 'package:flutter_sample_redux/gallery/redux/store/store.dart';
import 'package:flutter_sample_redux/gallery/redux/store/store_built.dart';
import 'package:flutter_sample_redux/gallery/repository/photo_repository.dart';
import 'package:flutter_sample_redux/shopping_list/model/shopping_state.dart';
import 'package:flutter_sample_redux/shopping_list/redux/store.dart';
import 'package:get_it/get_it.dart';
import 'package:redux/redux.dart';

GetIt injection = GetIt.I;

Future setInjections() async {
  Dio dio = Dio();
  dio.options.headers.putIfAbsent(HttpHeaders.contentTypeHeader, () => 'application/json');
  dio.options.baseUrl = ApiConstants.baseUrl;
  dio.options.connectTimeout = ApiConstants.timeoutDurationInMilliseconds;
  dio.options.receiveTimeout = ApiConstants.timeoutDurationInMilliseconds;
  dio.interceptors.add(ApiConstants.alice.getDioInterceptor());

  injection.registerLazySingleton<PhotoRepository<NewTypePhotoGeneric>>(() => ApiPhotoRepository(dio: dio));
  injection.registerLazySingleton<PhotoRepository<PopularTypePhotoGeneric>>(() => ApiPhotoRepository(dio: dio));

  final storeShopping = await createShoppingReduxStore();
  final storeCounter = await createCounterReduxStore();
  final storeGalleryNew = await createGalleryReduxStore<NewTypePhotoGeneric>();
  final storeGalleryPopular = await createGalleryReduxStore<PopularTypePhotoGeneric>();
  final storeGalleryBuildNew = storeBuilt<NewTypePhotoGeneric>(ApiPhotoRepository(dio: dio));
  final storeGalleryBuildPopular = storeBuilt<PopularTypePhotoGeneric>(ApiPhotoRepository(dio: dio));

  injection.registerLazySingleton<Store<ShoppingState>>(() => storeShopping);
  injection.registerLazySingleton<Store<CounterState>>(() => storeCounter);
  injection.registerLazySingleton<Store<GalleryState<NewTypePhotoGeneric>>>(() => storeGalleryNew);
  injection.registerLazySingleton<Store<GalleryState<PopularTypePhotoGeneric>>>(() => storeGalleryPopular);

  injection.registerLazySingleton<
      built_redux.Store<GalleryStateBuilt<NewTypePhotoGeneric>, GalleryStateBuiltBuilder<NewTypePhotoGeneric>,
          GalleryBuildActions>>(() => storeGalleryBuildNew);

  injection.registerLazySingleton<
      built_redux.Store<GalleryStateBuilt<PopularTypePhotoGeneric>, GalleryStateBuiltBuilder<PopularTypePhotoGeneric>,
          GalleryBuildActions>>(() => storeGalleryBuildPopular);
}
