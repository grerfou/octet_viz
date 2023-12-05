byte[] octetsDuFichier; 
int indexCoordonnee = 0; 

void setup() {

  String nomFichier = "chemin/vers/votre/fichier";
  

  octetsDuFichier = lireFichier(nomFichier); 
  // size(800, 600); 
  background(0); 
}

void draw() {
  if (octetsDuFichier != null) {

    if (indexCoordonnee < octetsDuFichier.length - 2) {

      float x = map(octetsDuFichier[indexCoordonnee], 0, 255, 0, width);
      float y = map(octetsDuFichier[indexCoordonnee + 1], 0, 255, 0, height);
      float z = map(octetsDuFichier[indexCoordonnee + 2], 0, 255, -200, 200);
      

      background(255); 
      stroke(0); 
      strokeWeight(5); 
      point(x, y, z); 
      

      indexCoordonnee += 3;
    }
  }
}

byte[] lireFichier(String nomFichier) {

  byte[] contenu = loadBytes(nomFichier);
  
  if (contenu != null) {
    return contenu; 
  } else {
    println("Le fichier n'a pas pu être chargé.");
    return null; 
  }
}
