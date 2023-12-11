PImage img;

void setup() {
  size(800, 600, P3D);
  img = loadImage("image.jpg"); // Charger une image spécifique
  img.loadPixels(); // Charger les pixels de l'image
}

void draw() {
  background(0);
  translate(width / 2, height / 2, -100);

  for (int i = 0; i < img.pixels.length; i += 10) {
    float x = map(i, 0, img.pixels.length, -300, 300); // Position en x en fonction de la taille de l'image
    float y = random(-200, 200); // Position en y aléatoire
    float z = random(-200, 200); // Position en z aléatoire

    color c = img.pixels[i];
    fill(c);
    noStroke();
    pushMatrix();
    translate(x, y, z);
    box(5); // Créer des cubes pour représenter les pixels de l'image
    popMatrix();
  }
}
