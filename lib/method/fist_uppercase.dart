class FistUppercase {
  String firstLetraMayuscula(String text) {
    if (text.isEmpty) return text; //Texto vacio lo deja igual
    return text[0].toUpperCase() + text.substring(1);
  }
}