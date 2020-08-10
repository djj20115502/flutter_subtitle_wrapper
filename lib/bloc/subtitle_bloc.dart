import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:fijkplayer/fijkplayer.dart';
import 'package:flutter/foundation.dart';
import 'package:subtitle_wrapper_package/data/models/subtitle.dart';
import 'package:subtitle_wrapper_package/data/models/subtitles.dart';
import 'package:subtitle_wrapper_package/data/repository/subtitle_repository.dart';
import 'package:subtitle_wrapper_package/subtitle_controller.dart';

part 'subtitle_event.dart';
part 'subtitle_state.dart';

class SubtitleBloc extends Bloc<SubtitleEvent, SubtitleState> {
  final FijkPlayer videoPlayerController;
  final SubtitleRepository subtitleRepository;

  Subtitles subtitles;

  SubtitleBloc({
    this.videoPlayerController,
    this.subtitleRepository,
  }) : super(SubtitleInitial());

  @override
  Stream<SubtitleState> mapEventToState(
    SubtitleEvent event,
  ) async* {
    if (event is LoadSubtitle) {
      yield* loadSubtitle();
    } else if (event is InitSubtitles) {
      yield* initSubtitles();
    } else if (event is UpdateLoadedSubtitle) {
      yield LoadedSubtitle(event.subtitle);
    }
  }

  Stream<SubtitleState> initSubtitles() async* {
    yield SubtitleInitializating();
    subtitles = await subtitleRepository.getSubtitles();
    yield SubtitleInitialized();
  }

  Stream<SubtitleState> loadSubtitle() async* {
    yield LoadingSubtitle();
    videoPlayerController.onCurrentPosUpdate.listen((event){
       if (event != null) {
        for (Subtitle subtitleItem in subtitles.subtitles) {
          if (event.inMilliseconds >
              subtitleItem.startTime.inMilliseconds &&
              event.inMilliseconds <
                  subtitleItem.endTime.inMilliseconds) {
            add(UpdateLoadedSubtitle(subtitle: subtitleItem));
          }
        }
      }
    });
   }
}
