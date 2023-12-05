

import peasy.*;

byte[] octetsDuFichier; 
int indexCoordonnee = 0; 
PVector positionPrecedente; 

PeasyCam cam;


void setup() {

  String nomFichier = "a.jpg";

  cam = new PeasyCam(this, 10);
  

  octetsDuFichier = lireFichier(nomFichier); 
  size(800, 600, P3D); 
  background(255); 
  positionPrecedente = new PVector(0, 0, 0); 
}

void draw() {
  if (octetsDuFichier != null) {

    if (indexCoordonnee < octetsDuFichier.length - 2) {

      float x = map(octetsDuFichier[indexCoordonnee], 0, 255, -width/2, width/2);
      float y = map(octetsDuFichier[indexCoordonnee + 1], 0, 255, -height/2, height/2);
      float z = map(octetsDuFichier[indexCoordonnee + 2], 0, 255, -200, 200);
      PVector positionActuelle = new PVector(x, y, z);
      

      stroke(0); // Couleur de la ligne
      strokeWeight(2); // Épaisseur de la ligne
      line(positionPrecedente.x, positionPrecedente.y, positionPrecedente.z, x, y, z);
      
      positionPrecedente.set(x, y, z);
      
      // Passer aux prochaines coordonnées (3 octets à la fois)
      indexCoordonnee += 3;
      println(indexCoordonnee);
    }
  }
}

byte[] lireFichier(String nomFichier) {
  // Chargement du fichier en tant qu'objet binaire
  byte[] contenu = loadBytes(nomFichier);
  
  if (contenu != null) {
    return contenu; // Retourne le tableau d'octets
  } else {
    println("Le fichier n'a pas pu être chargé.");
    return null; // Retourne null en cas d'échec du chargement du fichier
  }
}
