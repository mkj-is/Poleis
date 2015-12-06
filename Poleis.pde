

import java.util.ArrayList;
import java.util.Comparator;
import java.util.List;

public int textureCount = 8;
public boolean recording = false;

public static List<Building> buildingList = new ArrayList();

public static PImage texture;
public static int textureID = 0;

public static float sunXPos = 0.5f;
public static float sunYPos = 0.5f;

void settings() {
    fullScreen(P2D);
    pixelDensity(displayDensity());
}

void setup() {

    frameRate(24);

    texture = loadImage("gradient1.jpg");

    for (int i = 0; i < 50; i++) {
        Building b = new Building((int) random(width), this);
        buildingList.add(b);
    }

    sortDepths();

    textureMode(NORMAL);
    textureWrap(REPEAT);
    strokeWeight(0);
    noCursor();

}

void sortDepths() {
    buildingList.sort(new Comparator<Building>() {
        @Override
        public int compare(Building o1, Building o2) {
            return o1.depth - o2.depth;
        }
    });
}

void draw() {

    image(texture, 0, 0, width, height);

    boolean sort = false;

    for (Building b: buildingList) {
        b.draw(this);
        sort |= b.update();
    }

    if(sort) {
        sortDepths();
    }

    if (recording) {
        saveFrame("/Users/kaspar/Desktop/frames/city-######.png");
    }
}

void mouseMoved() {
    sunXPos = map(mouseX, 0, width, 0, 1);
    sunYPos = map(mouseY, 0, height, 0, 1);
}

void mouseClicked() {
    textureID++;
    if (textureID >= textureCount) {
        textureID = 0;
    }
    texture = loadImage("gradient" + textureID + ".jpg");
}


void keyPressed(KeyEvent event) {
    if (key == 'r') {
        recording = !recording;
    }
}