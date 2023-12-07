import peasy.*;

PeasyCam cam;
byte[][] octetsDuFichier; 

int sphereSize = 2;
int currentByte = 0;
ArrayList<PVector> positionsHistory = new ArrayList<PVector>();
float trailFadeSpeed = 50; 

float turn = 0;

void settings() {
    fullScreen(P3D, 0);
}



void setup() {

    // Import file 
    String nomFichier = "a(2160p).mp4";
    //  Read File
    octetsDuFichier = lireFichier(nomFichier); 

    //  Init cam
    cam = new PeasyCam(this, 1000);
    cam.setMinimumDistance(1);
    cam.setMaximumDistance(10000);

    // Speed anm
    frameRate(10);
}

void draw() {
    background(0); 
    // translate(width/2, height/2, -100);

    if (octetsDuFichier != null && currentByte < octetsDuFichier.length) {

        float x = map(octetsDuFichier[currentByte][0], 0, 3000, -5000, 5000); // mapping des valeurs 
        float y = map(octetsDuFichier[currentByte][1], 0, 3000, -5000, 5000);  
        float z = map(octetsDuFichier[currentByte][2], 0, 3000, -5000, 5000);  

        PVector currentPos = new PVector(x, y, z);
        positionsHistory.add(currentPos.copy());


        pushMatrix();
        // Axes visibility
        drawAxes(0, 0, turn);
        // Trainée point 
        drawTrail(5000, 5000, 5000, 0, 0, 0);
        popMatrix();
    

        // Rotation de la caméra autour de l'axe Y
        float rotationAngle = map(currentByte, 0, octetsDuFichier.length, 0, TWO_PI); 
        cam.beginHUD();
        cam.rotateY(rotationAngle);
        cam.endHUD();
        
        turn++;
        currentByte++;
    }
}


void drawTrail(float offsetX, float offsetY, float offsetZ, float rotx, float roty, float rotz) {
    stroke(181, 36, 1);
    noFill();

    pushMatrix();
    translate(offsetX, offsetY, offsetZ); // Translation pour la traînée
    rotateX(radians(rotx));
    rotateY(radians(roty));
    rotateZ(radians(rotz));

    for (int i = 0; i < positionsHistory.size() - 1; i++) {
        float alpha = map(i, 0, positionsHistory.size(), 255, 0);
        stroke(255, alpha);
        PVector pos1 = positionsHistory.get(i);
        PVector pos2 = positionsHistory.get(i + 1);
        line(pos1.x, pos1.y, pos1.z, pos2.x, pos2.y, pos2.z);
    }

    while (positionsHistory.size() > 5) {
        positionsHistory.remove(0);
    }
    popMatrix(); // Terminer la transformation
}


//  Read File
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


//  Draw axes 
void drawAxes(float rotx, float roty, float rotz) {

    rotateX(radians(rotx));
    rotateY(radians(roty));
    rotateZ(radians(rotz));

    // Axe X (rouge)
    stroke(255, 0, 0);
    line(0, 0, 0, 200, 0, 0);
    // Axe Y (vert)
    stroke(0, 255, 0);
    line(0, 0, 0, 0, 200, 0);
    // Axe Z (bleu)
    stroke(0, 0, 255);
    line(0, 0, 0, 0, 0, 200);
}