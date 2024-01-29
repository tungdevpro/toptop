extension StringExts on String {
  bool isValidUrl() {
    final regex = RegExp(r"(https?|http)://([-A-Z0-9.]+)(/[-A-Z0-9+&@#/%=~_|!:,.;]*)?(\?[A-Z0-9+&@#/%=~_|!:,.;]*)?");
    return (Uri.tryParse(this)?.hasAbsolutePath ?? false) || regex.hasMatch(this);
  }

  bool isStorage() => RegExp(r'^/(storage|data|private/var/mobile)[^.]').hasMatch(this);

  bool isAssetsPng() => isAssets() && endsWith('.png');

  bool isAssetsSvg() => isAssets() && endsWith('.svg');

  bool isAssets() => startsWith('assets');

  bool isPhoneVN() {
    RegExp regExp = RegExp(r"^(0|\+?84)(9[0-9]|8[1-9]|7[0-3,6-9]|5[2,5,6,8,9]|3[2-9]|2\d{2})\d{7}$", caseSensitive: false, multiLine: false);
    return regExp.hasMatch(this);
  }
}
