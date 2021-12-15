import 'dart:developer';

import 'package:built_redux/built_redux.dart' as built_redux;
import 'package:flutter/material.dart';
import 'package:flutter_sample_redux/di/injection.dart';
import 'package:flutter_sample_redux/flutter_built_redux.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';
import 'package:flutter_sample_redux/gallery/redux/actions/actions_build.dart';
import 'package:flutter_sample_redux/gallery/redux/model/type_photo_generic.dart';
import 'package:flutter_sample_redux/gallery/redux/state/gallery_state_built.dart';
import 'package:flutter_sample_redux/gallery/widgets/animation_loader.dart';
import 'package:flutter_sample_redux/gallery/widgets/gallery_app_bar.dart';
import 'package:flutter_sample_redux/gallery/widgets/pagination_widget.dart';
import 'package:flutter_sample_redux/gallery/widgets/photo_list.dart';
import 'package:flutter_sample_redux/gallery/widgets/progress_indicatior.dart';
import 'package:flutter_sample_redux/gallery_built/widgets/refresh_widget_built.dart';

class GalleryBuiltScreen extends StatefulWidget {
  const GalleryBuiltScreen({Key? key}) : super(key: key);

  @override
  _GalleryBuiltScreenState createState() => _GalleryBuiltScreenState();
}

class _GalleryBuiltScreenState extends State<GalleryBuiltScreen>
    with AutomaticKeepAliveClientMixin<GalleryBuiltScreen> {
  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance!.addPostFrameCallback((timeStamp) {
      final storeNewGallery = injection<
          built_redux.Store<GalleryStateBuilt<NewTypePhotoGeneric>, GalleryStateBuiltBuilder<NewTypePhotoGeneric>,
              GalleryBuildActions>>();
      if (storeNewGallery.state.photos.isEmpty) {
        storeNewGallery.actions.fetchByTypePhotoAction(TypePhoto.newPhoto);
      }
      final storePopularGallery = injection<
          built_redux.Store<GalleryStateBuilt<PopularTypePhotoGeneric>,
              GalleryStateBuiltBuilder<PopularTypePhotoGeneric>, GalleryBuildActions>>();
      if (storePopularGallery.state.photos.isEmpty) {
        storePopularGallery.actions.fetchByTypePhotoAction(TypePhoto.newPhoto);
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: const GalleryAppBar(title: 'Gallery built value/redux'),
        body: TabBarView(
          children: [
            ReduxProvider(
              store: injection<
                  built_redux.Store<GalleryStateBuilt<NewTypePhotoGeneric>,
                      GalleryStateBuiltBuilder<NewTypePhotoGeneric>, GalleryBuildActions>>(),
              child: _GalleryWidget<NewTypePhotoGeneric>(
                typePhoto: TypePhoto.newPhoto,
                scrollController: ScrollController(),
                // key: const ValueKey(TypePhoto.newPhoto),
              ),
            ),
            ReduxProvider(
              store: injection<
                  built_redux.Store<GalleryStateBuilt<PopularTypePhotoGeneric>,
                      GalleryStateBuiltBuilder<PopularTypePhotoGeneric>, GalleryBuildActions>>(),
              child: _GalleryWidget<PopularTypePhotoGeneric>(
                typePhoto: TypePhoto.popularPhoto,
                scrollController: ScrollController(),
                // key: const ValueKey(TypePhoto.newPhoto),
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  bool get wantKeepAlive => true;
}

class _GalleryWidget<T> extends StoreConnector<GalleryStateBuilt<T>, GalleryBuildActions, GalleryStateBuilt<T>> {
  final TypePhoto typePhoto;
  final ScrollController scrollController;

  const _GalleryWidget({Key? key, required this.typePhoto, required this.scrollController}) : super(key: key);

  @override
  Widget build(BuildContext context, GalleryStateBuilt<T> state, GalleryBuildActions actions) {
    return SizedBox.expand(
      child: state.isLoading
          ? const Center(child: ProgressIndicatorWidget())
          : Stack(
              children: [
                if (state.photos.isEmpty)
                  const Center(
                    child: CircularProgressIndicator(),
                  )
                else
                  RefreshWidgetBuilt<T>(
                    isLoading: state.isLoadingRefresh,
                    callRefresh: () {
                      actions.callRefreshAction(typePhoto);
                    },
                    child: PaginationWidget(
                      scrollController: scrollController,
                      callbackPagination: () {
                        log('isLoadingPagination ${state.isLoadingPagination}');
                        if (!state.isLoadingPagination) {
                          actions.fetchByTypePhotoAction(typePhoto);
                        }
                      },
                      child: PhotoList(
                        photos: state.photos,
                        scrollController: scrollController,
                      ),
                    ),
                  ),
                if (state.isLoadingPagination && !state.isLoading)
                  const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: AnimationLoader(),
                    ),
                  ),
              ],
            ),
    );
  }

  @override
  GalleryStateBuilt<T> connect(GalleryStateBuilt<T> state) => state;
}
