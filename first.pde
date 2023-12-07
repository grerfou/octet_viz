import ddf.minim.*;
import ddf.minim.analysis.*;
import peasy.*;
import peasy.org.apache.commons.math.geometry.*;

Minim minim;
AudioOutput out;
AudioPlayer player;
BeatDetect beat;
PeasyCam cam;

float[] waveX, waveY, waveZ;
int waveLength = 800;
float angle = 0.0;
float frequencyX = 0.03;
float frequencyY = 0.04;
float frequencyZ = 0.05;
  

void setup() {
  size(800, 600, P3D);
  minim = new Minim(this);
  
  // Charge un fichier audio (changez le chemin du fichier)
  player = minim.loadFile("a.mp3", 2048);
  player.play();
  
  out = minim.getLineOut();
  beat = new BeatDetect();
  waveX = new float[waveLength];
  waveY = new float[waveLength];
  waveZ = new float[waveLength];
  
  cam = new PeasyCam(this, 500);
}

void draw() {
  background(0);
  calculateWaves();
  renderAxes();
  
  pushMatrix();
  //rotateZ(rad);
  renderWave(waveX, color(255, 0, 0));
  popMatrix();
  
  pushMatrix();
  rotateZ(radians(90));
  renderWave(waveY, color(0, 255, 0));
  popMatrix();
  
  pushMatrix();
  rotateY(radians(90));
  renderWave(waveZ, color(0, 0, 255));
  popMatrix();

}

void calculateWaves() {
  beat.detect(player.mix);
  if (beat.isOnset()) {
    frequencyX = random(0.02, 0.08);
    frequencyY = random(0.02, 0.08);
    frequencyZ = random(0.02, 0.08);
  }
  
  angle += frequencyX;
  float xoff = angle;
  
  for (int i = 0; i < waveLength; i++) {
    waveX[i] = map(noise(xoff), 0, 1, -100, 100);
    xoff += 0.1;
  }
  
  angle += frequencyY;
  float yoff = angle;
  
  for (int i = 0; i < waveLength; i++) {
    waveY[i] = map(noise(yoff), 0, 1, -100, 100);
    yoff += 0.1;
  }
  
  angle += frequencyZ;
  float zoff = angle;
  
  for (int i = 0; i < waveLength; i++) {
    waveZ[i] = map(noise(zoff), 0, 1, -100, 100);
    zoff += 0.1;
  }
}

void renderWave(float[] wave, color c) {
  stroke(c);
  noFill();
  beginShape();
  
  for (int i = 0; i < waveLength; i++) {
    float x = i - waveLength / 2;
    float y = wave[i];
    float z = 0;
    vertex(x, y, z);
  }
  
  endShape();
}

void renderAxes() {
  // Axes X, Y, Z
  stroke(255, 0, 0); // X en rouge
  line(-width / 2, 0, 0, width / 2, 0, 0); // Axe X
  
  stroke(0, 255, 0); // Y en vert
  line(0, -height / 2, 0, 0, height / 2, 0); // Axe Y
  
  stroke(0, 0, 255); // Z en bleu
  line(0, 0, -height / 2, 0, 0, height / 2); // Axe Z
}
