import 'package:bloc/bloc.dart';
import 'package:meta/meta.dart';

import '../model/profile.dart';
import '../resource/profile_repository.dart';

part 'profile_event.dart';
part 'profile_state.dart';

class ProfileBloc extends Bloc<ProfileEvent, ProfileState> {
  ProfileRepository _repository = ProfileRepository();
  ProfileBloc() : super(ProfileInitial()) {
    on<FetchedProfileEvent>(_repository.getProfileData);
  }
}
