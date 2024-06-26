class Media {
  //Base Class
  void play() {
    print("Playing media...");
  }
}

class Song extends Media {
  //Derived Class
  String artist = "Arijit Singh"; //Artist String
  @override
  void play() {
    print("Playing song by $artist..."); //Overriding
  }
}

void main() {
  Media obj1 = Media(); //object of Media class
  Song obj2 = Song(); //Object of Song Class
  obj1.play();
  obj2.play();
}
