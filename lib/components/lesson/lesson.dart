class Lesson {
  Lesson(this.title, this.characterPhotos, this.currentPhotoIndex);

  final String title;
  final List<String> characterPhotos;
  int currentPhotoIndex;

  void setCurrentPhoto(int index) {
    currentPhotoIndex = index;
  }

  String getCurrentPhoto() {

    if (characterPhotos.isEmpty) {
      return "no";
    }

    return characterPhotos[currentPhotoIndex];
  }

}
