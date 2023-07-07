Future<String?> isOtpScreenAlreadyOpened(
        Future<String?> Function(String key) readSecureKey) =>
    readSecureKey("already_opened");
