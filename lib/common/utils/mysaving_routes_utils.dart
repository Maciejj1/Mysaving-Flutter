enum MYSAVING_PAGE { splash, login, register, tutorial, dashboard }

extension AppPageExtension on MYSAVING_PAGE {
  String get toPath {
    switch (this) {
      case MYSAVING_PAGE.splash:
        return "/splash";
      case MYSAVING_PAGE.login:
        return "/login";
      case MYSAVING_PAGE.register:
        return "/register";
      case MYSAVING_PAGE.tutorial:
        return "/tutorial";
      case MYSAVING_PAGE.dashboard:
        return "/";
      default:
        return "/";
    }
  }

  String get toName {
    switch (this) {
      case MYSAVING_PAGE.splash:
        return "splash";
      case MYSAVING_PAGE.login:
        return "login";
      case MYSAVING_PAGE.register:
        return "register";
      case MYSAVING_PAGE.tutorial:
        return "tutorial";
      case MYSAVING_PAGE.dashboard:
        return "dashboard";
      default:
        return "dashboard";
    }
  }
}
