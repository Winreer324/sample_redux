import 'dart:developer';

import 'package:flutter/material.dart';
import 'package:flutter_redux/flutter_redux.dart';
import 'package:flutter_sample_redux/di/injection.dart';
import 'package:flutter_sample_redux/gallery/enum/type_photo.dart';
import 'package:flutter_sample_redux/gallery/redux/actions.dart';
import 'package:flutter_sample_redux/gallery/redux/gallery_state.dart';
import 'package:flutter_sample_redux/gallery/redux/model/type_photo_generic.dart';
import 'package:redux/redux.dart';

import 'widgets/animation_loader.dart';
import 'widgets/pagination_widget.dart';
import 'widgets/photo_list.dart';
import 'widgets/progress_indicatior.dart';
import 'widgets/refresh_widget/widgets/refresh_widget.dart';

class GalleryScreen extends StatefulWidget {
  const GalleryScreen({Key? key}) : super(key: key);

  @override
  _GalleryScreenState createState() => _GalleryScreenState();
}

class _GalleryScreenState extends State<GalleryScreen>  {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 2,
      child: Scaffold(
        appBar: AppBar(
          title: const Text('Gallery'),
          automaticallyImplyLeading: false,
          backgroundColor: const Color(0xff5808e5),
          bottom: const TabBar(
            indicatorColor: Colors.white,
            tabs: [
              Tab(text: 'New'),
              Tab(text: 'Popular'),
            ],
          ),
        ),
        body: TabBarView(
          children: [
            GalleryWidget<NewTypePhotoGeneric>(
              typePhoto: TypePhoto.newPhoto,
              scrollController: ScrollController(),
              key: const ObjectKey(TypePhoto.newPhoto),
            ),
            GalleryWidget<PopularTypePhotoGeneric>(
              typePhoto: TypePhoto.popularPhoto,
              scrollController: ScrollController(),
              key: const ObjectKey(TypePhoto.popularPhoto),
            ),
          ],
        ),
      ),
    );
  }

}

class GalleryWidget<T> extends StatefulWidget {
  final TypePhoto typePhoto;
  final ScrollController scrollController;

  const GalleryWidget({Key? key, required this.typePhoto, required this.scrollController}) : super(key: key);

  @override
  _GalleryWidgetState<T> createState() => _GalleryWidgetState<T>();
}

class _GalleryWidgetState<T> extends State<GalleryWidget> with AutomaticKeepAliveClientMixin<GalleryWidget> {
  @override
  bool get wantKeepAlive => true;
  @override
  Widget build(BuildContext context) {
    return StoreProvider<GalleryState<T>>(
      store: injection<Store<GalleryState<T>>>(),
      child: SizedBox.expand(
        child: Stack(
          children: [
            StoreBuilder<GalleryState<T>>(
              onInit: (store) => store.dispatch(FistLoadingAction(widget.typePhoto)),
              // onInitialBuild:  (store) => store.dispatch(FistLoadingAction(widget.typePhoto)),
              builder: (context, store) {
                log(store.state.toString());
                if (store.state.isLoading) {
                  return const Center(child: ProgressIndicatorWidget());
                }

                if (store.state.photos.isNotEmpty) {
                  return StoreConnector<GalleryState<T>, GalleryState<T>>(
                    converter: (store) => store.state,
                    builder: (context, state) {
                      if (state.photos.isEmpty) {
                        return RefreshWidget<T>(
                          callRefresh: () {
                            store.dispatch(CallRefreshAction(widget.typePhoto));
                          },
                          scrollController: widget.scrollController,
                          child: const Center(
                            child: CircularProgressIndicator(),
                          ),
                        );
                      }

                      return RefreshWidget<T>(
                        callRefresh: () {
                          store.dispatch(CallRefreshAction(widget.typePhoto));
                        },
                        scrollController: widget.scrollController,
                        child: PaginationWidget(
                          scrollController: widget.scrollController,
                          callbackPagination: () {
                            log('isLoadingPagination ${state.isLoadingPagination}');
                            if (!state.isLoadingPagination) {
                              store.dispatch(FetchByTypePhotoAction(widget.typePhoto));
                            }
                          },
                          child: PhotoList(
                            photos: store.state.photos,
                            scrollController:widget.scrollController,
                          ),
                        ),
                      );
                    },
                  );
                }

                return const SizedBox();
              },
            ),
            StoreConnector<GalleryState<T>, GalleryState<T>>(
              converter: (store) => store.state,
              builder: (context, state) {
                if (state.isLoadingPagination && !state.isLoading) {
                  return const Align(
                    alignment: Alignment.bottomCenter,
                    child: Padding(
                      padding: EdgeInsets.only(bottom: 16),
                      child: AnimationLoader(),
                    ),
                  );
                }

                return const SizedBox();
              },
            ),
          ],
        ),
      ),
    );
  }
}
