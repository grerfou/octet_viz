import peasy.*;

PeasyCam cam;
byte[][] octetsDuFichier; 

void settings() {
    fullScreen(P3D, 0);
}

void setup() {
    String nomFichier = "a.pdf";
    octetsDuFichier = lireFichier(nomFichier); 

    cam = new PeasyCam(this, 100);
    cam.setMinimumDistance(100);
    cam.setMaximumDistance(5000);
}

void draw() {
    background(0); 
    translate(width/2, height/2, -100);

    if (octetsDuFichier != null) {
        for (int i = 0; i < octetsDuFichier.length; i++) {
            float x = map(octetsDuFichier[i][0], 0, 3000, -3000, 3000); // mapping des valeurs 
            float y = map(octetsDuFichier[i][1], 0, 3000, -3000, 3000);  
            float z = map(octetsDuFichier[i][2], 0, 3000, -3000, 3000);  
            
            stroke(255); // Couleur 
            strokeWeight(5); // Taille 
            point(x, y, z); // Dessiner 
        }
    }
}

byte[][] lireFichier(String nomFichier) {
    byte[] contenu = loadBytes(nomFichier);
  
    if (contenu != null) {
        int tailleTableauTroisOctets = contenu.length / 3;
        byte[][] tableauTroisOctets = new byte[tailleTableauTroisOctets][3];
        
        int index = 0;
        for (int j = 0; j < tailleTableauTroisOctets; j++) {
            for (int k = 0; k < 3; k++) {
                tableauTroisOctets[j][k] = contenu[index];
                index++;
            }
        }
        
        return tableauTroisOctets;
    } else {
        println("Le fichier n'a pas pu être chargé.");
        return null;
    }
}
