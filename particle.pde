public class Particle {
    private PApplet obj;
    private Point[] points;
    private final int POINT_NUM = 50;
    private float r = 2.0;
    private boolean visible = false;
    private boolean drawFlag = false;
    private boolean runFlag = false;
    private long startTime;
    private color c = color(255);
    private float x;
    private float y;
    
    Particle(PApplet _obj) {
        points = new Point[POINT_NUM];
        obj = _obj;
        obj.registerMethod("draw", this);
    }
    
    Particle setParticle(float x, float y) {
        for (int i = 0; i < POINT_NUM; i++) {
            float theta = random(2 * PI);
            points[i] = new Point(x, y, cos(theta) * random(0.5*r/2, 3*r/2), sin(theta) * random(0.5*r/2, 3*r/2), random(5*r/2, 10*r/2));
        }
        visible = true;
        startTime = millis();
        return this;
    }
    
    void draw() {
        if (runFlag) {
            runFlag = false;
            if (!drawFlag) {
                setParticle(x, y);
                drawFlag = true;
                visible = true;
            }
        }
        else {
            drawFlag = false;
        }
        
        if (!visible) {
            return;
        }
        
        for (Point p : points) {
            p.draw();
            p.update();
        }
        if (millis() - startTime > r*1000) {
            visible = false;
        }
    }
    
    Particle drawing(float _x, float _y) {
        this.x = _x;
        this.y = _y;
        runFlag = true;
        return this;
    }

    Particle setColor(color _c) {
        c = _c;
        return this;
    }
    
    Particle setRadius(float _r) {
        r = _r;
        return this;
    }
    
    boolean isDrawing() {
        return visible;
    }
    
    private class Point {
        PVector pos;
        PVector vec;
        float r;
        
        Point(float x, float y, float vx, float vy, float _r) {
            pos = new PVector(x, y);
            vec = new PVector(vx, vy);
            this.r = _r;
        }
        
        void draw() {
            fill(c);
            noStroke();
            circle(pos.x, pos.y, r);
        }
        
        void update() {
            pos.add(vec);
            vec.mult(0.90);
            r *= 0.95;
        }
    }
}
