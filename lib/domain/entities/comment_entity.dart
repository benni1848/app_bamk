class CommentEntity {
  //final String _id;
  final String title;
  final String inhalt;
  final String username;
  final String mediatype;
  final String id;
  final String erstelltAm;
  final String rating;

  const CommentEntity({
    //required this._id,
    required this.title,
    required this.inhalt,
    required this.username,
    required this.mediatype,
    required this.id,
    required this.erstelltAm,
    required this.rating,
  });
}