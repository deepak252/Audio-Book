class Audio{
  final String title;
  final String author;
  final String filePath;
  final String logo;

  Audio({
    required this.title, 
    required this.author, 
    required this.filePath, 
    required this.logo});
  
  factory Audio.fromJson(json)=> Audio(
    title: json["title"],
    author: json["author"],
    filePath: json["filePath"],
    logo: json["logo"],
  );
}