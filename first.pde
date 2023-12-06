import peasy.*;

PeasyCam cam;
byte[][] octetsDuFichier; 
int sphereSize = 5;
int currentByte = 0;
ArrayList<PVector> positionsHistory = new ArrayList<PVector>();
float trailFadeSpeed = 50; // Vitesse de diminution de l'opacité de la trainée

void settings() {
    fullScreen(P3D, 0);
}

void setup() {
    String nomFichier = "a.mp3";
    octetsDuFichier = lireFichier(nomFichier); 

    cam = new PeasyCam(this, 100);
    cam.setMinimumDistance(1);

    frameRate(10);
}

void draw() {
    background(0); 
    translate(width/2, height/2, -100);

    if (octetsDuFichier != null && currentByte < octetsDuFichier.length) {
        float x = map(octetsDuFichier[currentByte][0], 0, 3000, -width/2, width/2); // mapping des valeurs 
        float y = map(octetsDuFichier[currentByte][1], 0, 3000, -height/2, height/2);  
        float z = map(octetsDuFichier[currentByte][2], 0, 3000, -1000, 1000);  

        PVector currentPos = new PVector(x, y, z);
        positionsHistory.add(currentPos.copy());

        pushMatrix();

        translate(x, y, z);
        fill(255);
        noStroke();
        lights();
        sphere(sphereSize);

        popMatrix();
        
        // Trainée
        drawTrail();

        // Rotation de la caméra autour de l'axe Y
        float rotationAngle = map(currentByte, 0, octetsDuFichier.length, 0, TWO_PI); // Utilisation de l'avancement dans la lecture du fichier pour calculer l'angle de rotation
        cam.beginHUD();
        cam.rotateY(rotationAngle);
        cam.endHUD();
        
        currentByte++;
    }
}


void drawTrail() {
    stroke(181, 36, 1);
    noFill();
    for (int i = 0; i < positionsHistory.size() - 1; i++) {
        float alpha = map(i, 0, positionsHistory.size(), 255, 0); // Opacité basée sur la position dans l'historique
        stroke(181, 36, 1, alpha); // Appliquer l'opacité
        PVector pos1 = positionsHistory.get(i);
        PVector pos2 = positionsHistory.get(i + 1);
        line(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
    }
    
    // Effacer les positions les plus anciennes pour créer l'effet de trainée qui s'efface
    while (positionsHistory.size() > 3) { // Taille de l'historique des points
        positionsHistory.remove(0);
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