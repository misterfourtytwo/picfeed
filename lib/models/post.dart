class Post {
  final String image;
  final String thumbnail;
  final String link;
  final String title;
  final String id;

  Post({
    this.id,
    this.link = '',
    this.title = '',
    this.image = '',
    this.thumbnail = '',
  });

  @override
  String toString() {
    return 'Post(image: $image, thumbnail: $thumbnail, link: $link, title: $title, id: $id)';
  }
}
