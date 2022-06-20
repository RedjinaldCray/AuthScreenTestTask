abstract class StateAuthenticationScreen {}

class StateAuthenticationScreenInit extends StateAuthenticationScreen {}

class StateAuthenticationScreenLoading extends StateAuthenticationScreen {}

class StateAuthenticationScreenSuccess extends StateAuthenticationScreen {}

class StateAuthenticationScreenShowDanceElon extends StateAuthenticationScreen {
}

class StateAuthenticationScreenShowBadElon extends StateAuthenticationScreen {}

class StateAuthenticationScreenError extends StateAuthenticationScreen {
  final int? error;
  final String? message;
  StateAuthenticationScreenError({this.error, this.message});
}
