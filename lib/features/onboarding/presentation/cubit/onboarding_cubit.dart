import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:final_project/main.dart'; // To access sharedPreferences

part 'onboarding_state.dart';

class OnboardingCubit extends Cubit<OnboardingState> {
  OnboardingCubit() : super(const OnboardingState());

  void pageChanged(int page) {
    emit(OnboardingState(currentPage: page));
  }

  Future<void> completeOnboarding() async {
    // This logic doesn't really produce a "state" for the UI,
    // but it's good practice to keep side-effects like this in the business logic layer.
    await sharedPreferences.setBool('hasSeenOnboarding', true);
  }
}