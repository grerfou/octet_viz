import peasy.*;

PeasyCam cam;

byte[] octetsDuFichier; 

void settings(){
    fullScreen(P3D, 0);
}

void setup() {

  String nomFichier = "a.jpg";

  octetsDuFichier = lireFichier(nomFichier); 

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(5000);

//   size(1000, 1000, P3D);
}

void draw() {
    background(0); 
}


//  Lecture du fichier en bytes 
byte[] lireFichier(String nomFichier) {
    
}
