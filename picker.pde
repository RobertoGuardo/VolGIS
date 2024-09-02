class Picker {

  PGraphics buffer;

  PImage palette = loadImage("palette.png");

  int index = 0;

  color fill = color(0);


  //•••••••••••••••••••••••••

  Picker() {

    buffer = createGraphics(width, height, P3D);
  }

  //•••••••••••••••••••••••••  

  Picker(int w_, int h_) {

    buffer = createGraphics(w_, h_, P3D);
  }

  //•••••••••••••••••••••••••

  void setFill(color c) {

    fill = c;
  }

  //•••••••••••••••••••••••••

  void setFillByIndex(int i) {

    fill = palette.pixels[i];

    buffer.fill(fill);
  }

  //•••••••••••••••••••••••••

  color getColorByIndex(int i) {

    return  palette.pixels[i];
  }

  //•••••••••••••••••••••••••

  int getNewColorIndex() {

    index ++;

    return index;
  }

  //•••••••••••••••••••••••••

  color getNewColor() {

    index ++;

    return  palette.pixels[index];
  }

  //•••••••••••••••••••••••••

  boolean compareColors(int x, int y, int index) {

    boolean aux = false;

    if (readColor(x, y) == getColorByIndex(index)) {
      aux =true;
    }

    return aux;
  }

  //•••••••••••••••••••••••••

  void advanceIndex() {

    index ++;

    println(index);
  }

  //•••••••••••••••••••••••••

  PGraphics getBuffer() {

    return buffer;
  }

  //•••••••••••••••••••••••••

  void prepareBufferer() {

    buffer.beginDraw();

    buffer.background(255);

    buffer.noStroke();
  }

  //•••••••••••••••••••••••••

  void closeBuffer() {

    buffer.endDraw();
  }

  //•••••••••••••••••••••••••

  void setBufferCamera(float eyeX, float eyeY, float eyeZ, float centerX, float centerY, float centerZ, float upX, float upY, float upZ) {
    buffer.camera(eyeX, eyeY, eyeZ, centerX, centerY, centerZ, upX, upY, upZ);
  }

  //•••••••••••••••••••••••••

  void exportBuffer() {

    buffer.save("buffer.png");
  }

  //•••••••••••••••••••••••••

  color readColor(int x, int y) {

    color c = buffer.get(x, y);

    return c;
  }
}