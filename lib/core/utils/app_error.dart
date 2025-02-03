class AppError {
  static String getMessage(Object error) {
    if (error.toString().contains('user-not-found')) {
      return 'ユーザーが見つかりません';
    }
    if (error.toString().contains('wrong-password')) {
      return 'パスワードが間違っています';
    }
    if (error.toString().contains('email-already-in-use')) {
      return 'このメールアドレスは既に使用されています';
    }
    if (error.toString().contains('invalid-email')) {
      return 'メールアドレスの形式が正しくありません';
    }
    if (error.toString().contains('weak-password')) {
      return 'パスワードが弱すぎます';
    }
    if (error.toString().contains('network-request-failed')) {
      return 'ネットワークエラーが発生しました';
    }
    return 'エラーが発生しました: $error';
  }
}
