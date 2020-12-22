class HandleApiString {
  static String removeInapropriatedCharacter(String text) {
    String newText = '';
    bool containImage = text.contains('wp-block-image');
    bool containVideo = text.contains('wp-block-embed');
    text = text.replaceAll('<p>', '');
    text = text.replaceAll('</p>', '');
    text = text.replaceAll('<strong>', '');
    text = text.replaceAll('</strong>', '');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&nbsp;', '');
    text = text.replaceAll('<br>', '\n');
    text = text.replaceAll('[&hellip;]', '');
    text = text.replaceAll('&#8220;', '"');
    text = text.replaceAll('&#8221;', '"');
    text = text.replaceAll('&#8217;', '\'');
    text = text.replaceAll('&#8230;', '...');

    if (containImage) {
      newText += text.substring(0, text.indexOf('<figure'));
      newText += text.substring(text.indexOf('</figure>') + 9, text.length);
      newText = newText.split('<figure').first.trim();
      return newText.trim();
    }

    newText = text;

    if (containVideo) {
      newText = newText.split('<figure').first.trim();
      return newText.trim();
    }

    return newText.trim();
  }

  static String getVideoLink(String text) {
    if (text.contains('<figure class')) {
      return text.split('src="').last.split('"').first.trim();
    }
    return null;
  }

  static String getVideoTitle(String text) {
    if (text.contains('<figure class')) {
      return text.split('<iframe title=\"').last.split('\"').first.trim();
    }
    return null;
  }

  static String getImageSrc(String text) {
    bool containImage = text.contains('<figure class=\"wp-block-image');
    if (containImage) {
      return text.split('<figure class=\"wp-block-image').last.split('</figure>').first.split('src="').last.split('"').first;
    }
    return null;
  }
}
