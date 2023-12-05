import peasy.*;

PeasyCam cam;

byte[] octetsDuFichier; 

void settings(){
    fullScreen(P3D, 0);
}

void setup() {

  String nomFichier = "a.mp3";

  octetsDuFichier = lireFichier(nomFichier); 

  cam = new PeasyCam(this, 100);
  cam.setMinimumDistance(10);
  cam.setMaximumDistance(5000);

//   size(1000, 1000, P3D);
}

void draw() {
    background(0); 
    //translate(width/2, height/2, -100);


    if (octetsDuFichier != null) {
        for (int i = 0; i < octetsDuFichier.length; i += 3) {
        float x = map(octetsDuFichier[i], 0, 3000, -1000, 1000);      //  mapping des valeurs 
        float y = map(octetsDuFichier[i + 1], 0, 3000, -1000, 1000);  
        float z = map(octetsDuFichier[i + 2], 0, 3000, -1000, 1000);  
        
        // Dessinner point position (x, y, z)
        stroke(255); // Couleur 
        strokeWeight(5); // Taille 
        point(x, y, z); // Dessiner 
        }
    }
}


//  Lecture du fichier en bytes 
byte[] lireFichier(String nomFichier) {
    // Chargement du fichier (binaire
    byte[] contenu = loadBytes(nomFichier);
  
    if (contenu != null) {
        println("Contenu du fichier : ");
        // Affichage des octets du fichier
        for (int i = 0; i < contenu.length; i++) {
        print(contenu[i] + " ");
        }
        println(); 
        
        // Organiser les octets en groupes de trois
        int tailleTableauTroisOctets = contenu.length / 3;
        byte[][] tableauTroisOctets = new byte[tailleTableauTroisOctets][3];
        
        int index = 0;

        for (int j = 0; j < tailleTableauTroisOctets; j++) {
        for (int k = 0; k < 3; k++) {
            tableauTroisOctets[j][k] = contenu[index];
            index++;
        }
        }

        // Affichage des groupes de trois octets
        println("Octets organisés par groupe de trois : ");
        for (int j = 0; j < tailleTableauTroisOctets; j++) {
        for (int k = 0; k < 3; k++) {
            print(tableauTroisOctets[j][k] + " ");
        }
        println();
        }
        
        return contenu; // Retourne le tableau d'octets
    } else {
        println("Le fichier n'a pas pu être chargé.");
        return null; // Retourne null en cas d'échec du chargement du fichier
    }
}
