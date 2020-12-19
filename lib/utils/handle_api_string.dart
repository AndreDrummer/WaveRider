class HandleApiString {
  static String removeInapropriatedCharacter(String text) {
    text = text.replaceAll('<p>', '');
    text = text.replaceAll('</p>', '');
    text = text.replaceAll('<strong>', '');
    text = text.replaceAll('</strong>', '');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&nbsp;', '');
    text = text.replaceAll('<br>', '\n');
    text = text.replaceAll('[&hellip;]', '');

    if (text.contains('<figure class')) {
      return text.split('<figure class').first.trim();
    }

    return text.trim();
  }

  static String getVideoLink(String text) {
    if (text.contains('<figure class')) {
      print(text.split('src="').last.split('"').first);
      return text.split('src="').last.split('"').first.trim();
    }
    return null;
  }

  static String getVideoTitle(String text) {
    if (text.contains('<figure class')) {
      print(text.split('<iframe title=\"').last.split('\"').first);
      return text.split('<iframe title=\"').last.split('\"').first.trim();
    }
    return null;
  }
}
