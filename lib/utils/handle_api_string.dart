class HandleApiString {
  static String removeInapropriatedCharacter(String text) {
    bool containImage = text.contains('<figure class=\"wp-block-image');
    bool containVideo = text.contains('<figure class=\"wp-block-embed is-type-video');
    text = text.replaceAll('<p>', '');
    text = text.replaceAll('</p>', '');
    text = text.replaceAll('<strong>', '');
    text = text.replaceAll('</strong>', '');
    text = text.replaceAll('&amp;', '&');
    text = text.replaceAll('&nbsp;', '');
    text = text.replaceAll('<br>', '\n');
    text = text.replaceAll('[&hellip;]', '');

    if (containImage) {
      return text.split('</figure>')[1].trim().split('<figure class').first.trim();
    }

    if (containVideo) {
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
      return text.split('<iframe title=\"').last.split('\"').first.trim();
    }
    return null;
  }

  static String getImageSrc(String text) {
    bool containImage = text.contains('<figure class=\"wp-block-image');
    if (containImage) {
      print(text.split('<figure class=\"wp-block-image').last.split('</figure>').first.split('src="').last.split('"').first);
      return text.split('<figure class=\"wp-block-image').last.split('</figure>').first.split('src="').last.split('"').first;
    }
    return null;
  }
}
