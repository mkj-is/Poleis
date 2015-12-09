import processing.core.PApplet;

public class Building {

    public static final int maxDepth = 5;
    public static final float minHeight = 150;
    public static final float maxHeight = 650;
    public static final float minWidth = 80;
    public static final float maxWidth = 160;
    public static final float speed = 0.25f;
    public static final float viewMagnitude = 25;

    public int depth;
    public float rotation;
    public float height;
    public float width;
    public float position;

    public Poleis applet;

    Building(int pos, Poleis a) {
        applet = a;
        reset();
        position = pos;
    }

    void reset() {
        depth = (int)(Math.random() * maxDepth);
        rotation = applet.random(1);
        height = minHeight + (float)Math.random() * (maxHeight - minHeight);
        width = minWidth + (float)Math.random() * (maxWidth - minWidth);
        position += applet.width + width * 2 + Math.random() * 50;
    }

    void draw(PApplet applet) {
        applet.stroke(255 / (maxDepth - depth));
        int base = applet.height;

        float angle = applet.acos(rotation * 2 - 1);
        float centre = applet.map(height, minHeight, maxHeight, viewMagnitude, -viewMagnitude);

        applet.beginShape();
        applet.texture(Poleis.texture);
        applet.vertex(position - (1 - rotation) * width, base - height, 0, Poleis.sunYPos);
        applet.vertex(position, base - height + centre * applet.sin(angle), 0, Poleis.sunYPos);
        applet.vertex(position + rotation * width, base - height, 0, Poleis.sunYPos);
        applet.vertex(position + rotation * width - (1 - rotation) * width, base - height - centre * applet.sin(angle), 0, Poleis.sunYPos);
        applet.endShape();

        applet.beginShape();
        applet.texture(Poleis.texture);
        applet.vertex(position, base, Poleis.sunXPos, Poleis.sunYPos);
        applet.vertex(position, base - height + centre * applet.sin(angle), Poleis.sunXPos, 0);
        applet.vertex(position + rotation * width, base - height, 0, Poleis.sunYPos);
        applet.vertex(position + rotation * width, base, 0, Poleis.sunYPos);
        applet.endShape();

        applet.beginShape();
        applet.texture(Poleis.texture);
        applet.vertex(position, base, Poleis.sunXPos, Poleis.sunYPos);
        applet.vertex(position, base - height + centre * applet.sin(angle), Poleis.sunXPos, Poleis.sunYPos);
        applet.vertex(position - (1 - rotation) * width, base - height, 0, Poleis.sunYPos);
        applet.vertex(position - (1 - rotation) * width, base, 0, Poleis.sunYPos);
        applet.endShape();

    }

    boolean update() {
        position -= speed * (depth + 1);

        if (position < -width / 2) {
            reset();
            return true;
        }
        return false;
    }
}