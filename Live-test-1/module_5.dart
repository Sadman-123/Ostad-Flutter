class Media {
  void play() {
    print("Playing media...");
  }
}

class Song extends Media {
  String artist = "Arijit Singh";
  @override
  void play() {
    print("Playing song by $artist...");
  }
}

void main() {
  Media obj1 = Media();
  Song obj2 = Song();
  obj1.play();
  obj2.play();
}
