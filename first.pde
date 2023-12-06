

import peasy.*;

byte[] octetsDuFichier; 
int indexCoordonnee = 0; 
PVector positionPrecedente; 

PeasyCam cam;

void settings(){
    fullScreen(P3D, 0);
}

void setup() {

  String nomFichier = "a.jpg";

  cam = new PeasyCam(this, 200);
  

  octetsDuFichier = lireFichier(nomFichier); 
  // size(800, 600, P3D); 
  background(0); 
  positionPrecedente = new PVector(0, 0, 0); 
}

void draw() {
  if (octetsDuFichier != null) {

    if (indexCoordonnee < octetsDuFichier.length - 2) {
        
        float x = map(octetsDuFichier[indexCoordonnee], 0, 255, -width/2, width/2);
        float y = map(octetsDuFichier[indexCoordonnee + 1], 0, 255, -height/2, height/2);
        float z = map(octetsDuFichier[indexCoordonnee + 2], 0, 255, -height/2, height/2);
        PVector positionActuelle = new PVector(x, y, z);

        //pushMatrix();
        stroke(255); 
        strokeWeight(2); 
        line(positionPrecedente.x, positionPrecedente.y, positionPrecedente.z, x, y, z);
        //popMatrix(); 

        positionPrecedente.set(x, y, z);


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
