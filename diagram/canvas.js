function canvas() {
    let d = new SimpleDiagram.Diagram("box");
    d.layout({
        containers: {
            c1: {
                d: SimpleDiagram.Direction.Vertical,
                x: 100,
                y: 100,
                b: ["x1", "x2", "x3", "x4", "x5", "x6", "x7"],
            },
            c2: {
                d: SimpleDiagram.Direction.Horizontal,
                x: 300,
                y: 50,
                b: ["y1", "y2", "y3", "y4", "y5", "y6", "y7"],
            },
            c3: {
                d: SimpleDiagram.Direction.Horizontal,
                x: 300,
                y: 300,
                b: ["z1", "z2", "z3", "z4", "z5", "z6", "z7"],
            },
        },
    });
}
var SimpleDiagram;
(function (SimpleDiagram) {
    class Diagram {
        constructor(id) {
            this.id = id;
            this.containers = new Map();
            this.boxen = new Map();
            this.arrows = [];
            this.logger = new Logger();
            this.g = null;
            this.g = new Global(id);
        }
        layout(layout) {
            for (const key in layout) {
                const obj = layout[key];
                if (key === 'containers') {
                    for (const cname in obj) {
                        console.log(`cname: ${cname}`);
                        this.layoutContainer(cname, obj[cname]);
                    }
                }
            }
        }
        layoutContainer(name, obj) {
            const direction = obj['d'];
            const x = obj['x'];
        }
        draw() {
            for (let i of this.containers.values()) {
                i.draw();
            }
            for (let i of this.boxen.values()) {
                i.draw();
            }
            for (let i of this.arrows) {
                i.draw();
            }
        }
        container(text, direction, x, y) {
            const c = new Container(this.g, direction, x, y);
            this.containers.set(text, c);
            return c;
        }
        lookupBox(t) {
            var b = undefined;
            b = typeof t === 'string' ? this.boxen.get(t) : t;
            if (b === undefined) {
                for (let i of this.containers.values()) {
                    b = i.lookup(t);
                    if (b) {
                        break;
                    }
                }
            }
            return b;
        }
        arrow(from, to) {
            const a = new Arrow(this.g, this.lookupBox(from), this.lookupBox(to));
            this.arrows.push(a);
            return a;
        }
    }
    SimpleDiagram.Diagram = Diagram;
    class Logger {
        info(p, o) {
            console.warn(`${p.constructor['name']}:${JSON.stringify(o)}`);
        }
    }
    class BoxConfig {
        constructor(fillCollor = 'lightgrey', borderColor = 'black', fontColor = 'black', fontSize = '1.25rem', fontFamily = 'Comic Sans MS', align = 'center', xPad = 5, yPad = 10) {
            this.fillCollor = fillCollor;
            this.borderColor = borderColor;
            this.fontColor = fontColor;
            this.fontSize = fontSize;
            this.fontFamily = fontFamily;
            this.align = align;
            this.xPad = xPad;
            this.yPad = yPad;
        }
    }
    class ArrowConfig {
        constructor(fillCollor = 'black', width = 3, headWidth = 8, headLength = 12, circleRadius = 4) {
            this.fillCollor = fillCollor;
            this.width = width;
            this.headWidth = headWidth;
            this.headLength = headLength;
            this.circleRadius = circleRadius;
        }
    }
    class ContainerConfig {
        constructor(xPad = 5, yPad = 5, xSpacing = 20, ySpacing = 30, fillCollor = '#eff0f2', borderColor = 'black') {
            this.xPad = xPad;
            this.yPad = yPad;
            this.xSpacing = xSpacing;
            this.ySpacing = ySpacing;
            this.fillCollor = fillCollor;
            this.borderColor = borderColor;
        }
    }
    let Direction;
    (function (Direction) {
        Direction[Direction["Horizontal"] = 0] = "Horizontal";
        Direction[Direction["Vertical"] = 1] = "Vertical";
    })(Direction = SimpleDiagram.Direction || (SimpleDiagram.Direction = {}));
    class Point {
        constructor(x, y) {
            this.x = x;
            this.y = y;
        }
    }
    let Sides;
    (function (Sides) {
        Sides[Sides["Top"] = 0] = "Top";
        Sides[Sides["Left"] = 1] = "Left";
        Sides[Sides["Bottom"] = 2] = "Bottom";
        Sides[Sides["Right"] = 3] = "Right";
    })(Sides || (Sides = {}));
    class Bounds {
        constructor(g, x, y, h, w) {
            this.g = g;
            this.x = x;
            this.y = y;
            this.h = h;
            this.w = w;
            this.tl = null;
            this.tr = null;
            this.bl = null;
            this.br = null;
            this.tm = null;
            this.lm = null;
            this.bm = null;
            this.rm = null;
            this.tl = new Point(this.x, this.y);
            this.tr = new Point(this.x + this.w, this.y);
            this.bl = new Point(this.x, this.y + this.h);
            this.br = new Point(this.x + this.w, this.y + this.h);
            this.tm = new Point(this.x + this.w / 2, this.y);
            this.lm = new Point(this.x, this.y + this.h / 2);
            this.bm = new Point(this.x + this.w / 2, this.y + this.h);
            this.rm = new Point(this.x + this.w, this.y + this.h / 2);
        }
        middlePoints(filters) {
            const points = [];
            if (filters.length == 0) {
                points.push(this.tm, this.lm, this.bm, this.rm);
            }
            else {
                for (let f of filters) {
                    switch (f) {
                        case Sides.Bottom:
                            points.push(this.bm);
                            break;
                        case Sides.Top:
                            points.push(this.tm);
                            break;
                        case Sides.Right:
                            points.push(this.rm);
                            break;
                        case Sides.Left:
                            points.push(this.lm);
                            break;
                    }
                }
            }
            return points;
        }
        log() {
            this.g.logger.info(this, { x: this.x, y: this.y, w: this.w, h: this.h });
        }
    }
    class Arrow {
        constructor(g, from, to) {
            this.g = g;
            this.from = from;
            this.to = to;
        }
        drawCircle(path) {
            const p = path[0];
            this.g.context.beginPath();
            this.g.context.arc(p.x, p.y, this.g.arrow.circleRadius, 0, 2 * Math.PI);
            this.g.context.stroke();
            this.g.context.fill();
        }
        drawArrow(path) {
            const to = path[path.length - 1];
            const from = path[path.length - 2];
            const dx = to.x - from.x;
            const dy = to.y - from.y;
            const rot = -Math.atan2(dx, dy);
            const len = Math.sqrt(dx * dx + dy * dy);
            const ctx = this.g.context;
            ctx.save();
            ctx.translate(from.x, from.y);
            ctx.rotate(rot);
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(0, len - this.g.arrow.headLength);
            ctx.stroke();
            ctx.save();
            ctx.translate(0, len);
            this.drawArrowHead();
            ctx.restore();
            ctx.restore();
        }
        drawArrowHead() {
            const ctx = this.g.context;
            ctx.beginPath();
            ctx.moveTo(0, 0);
            ctx.lineTo(-this.g.arrow.headWidth, -this.g.arrow.headLength);
            ctx.lineTo(this.g.arrow.headWidth, -this.g.arrow.headLength);
            ctx.closePath();
            ctx.fill();
        }
        drawLine(path) {
            this.g.context.beginPath();
            this.g.context.moveTo(path[0].x, path[0].y);
            for (let p of path) {
                this.g.context.lineTo(p.x, p.y);
            }
            this.g.context.strokeStyle = this.g.arrow.fillCollor;
            this.g.context.lineWidth = this.g.arrow.width;
            this.g.context.stroke();
        }
        calcOpenSides(b) {
            const sides = [];
            if (b.c) {
                if (b.c.direction == Direction.Vertical) {
                    sides.push(Sides.Left, Sides.Right);
                }
                else {
                    sides.push(Sides.Top, Sides.Bottom);
                }
            }
            return sides;
        }
        calcClosestPoints(from, to) {
            const table = new Map();
            const fSides = this.calcOpenSides(from);
            const tSides = this.calcOpenSides(to);
            const fBounds = from.calcBoxBounds();
            const tBounds = to.calcBoxBounds();
            for (let f of fBounds.middlePoints(fSides)) {
                for (let t of tBounds.middlePoints(tSides)) {
                    const a = f.x - t.x;
                    const b = f.y - t.y;
                    const c = Math.sqrt(a * a + b * b);
                    table.set(c, [f, t]);
                }
            }
            const min = Math.min(...Array.from(table.keys()));
            return table.get(min);
        }
        calcPath() {
            const sides = this.calcOpenSides(this.to);
            const match = this.calcClosestPoints(this.from, this.to);
            const from = match[0];
            const to = match[1];
            const path = [];
            path.push(from);
            if (sides.some(s => s == Sides.Top || s == Sides.Bottom)) {
                path.push(new Point(to.x, from.y));
            }
            else {
                path.push(new Point(from.x, to.y));
            }
            path.push(to);
            return path;
        }
        draw() {
            const path = this.calcPath();
            const tSides = this.calcOpenSides(this.to);
            this.drawCircle(path);
            this.drawLine(path);
            this.drawArrow(path);
        }
    }
    class Global {
        constructor(id, box = new BoxConfig(), container = new ContainerConfig(), arrow = new ArrowConfig(), logger = new Logger()) {
            this.id = id;
            this.box = box;
            this.container = container;
            this.arrow = arrow;
            this.logger = logger;
            this.canvas = null;
            this.context = null;
            this.canvas = document.getElementById(this.id);
            this.context = this.canvas.getContext("2d");
        }
        percentScale(bbox, px, py) {
            const x = bbox.tl.x - px;
            const y = bbox.tl.y - py;
            const rx = bbox.br.x + px;
            const by = bbox.br.y + py;
            const h = by - y;
            const w = rx - x;
            return new Bounds(this, x, y, h, w);
        }
    }
    class Box {
        constructor(g, x, y, t, c = null) {
            this.g = g;
            this.x = x;
            this.y = y;
            this.t = t;
            this.c = c;
        }
        calcTextBounds() {
            this.g.context.font = `${this.g.box.fontSize} ${this.g.box.fontFamily}`;
            const h = this.g.context.measureText("M").width;
            const w = this.g.context.measureText(this.t).width;
            return new Bounds(this.g, this.x - w / 2, this.y - h, h, w);
        }
        calcBoxBounds() {
            const textBounds = this.calcTextBounds();
            return this.g.percentScale(textBounds, this.g.box.xPad, this.g.box.yPad);
        }
        draw() {
            const boxBounds = this.calcBoxBounds();
            this.g.context.beginPath();
            this.g.context.fillStyle = this.g.box.fillCollor;
            this.g.context.fill();
            this.g.context.strokeStyle = this.g.box.borderColor;
            this.g.context.rect(boxBounds.x, boxBounds.y, boxBounds.w, boxBounds.h);
            this.g.context.stroke();
            this.g.context.beginPath();
            this.g.context.fillStyle = this.g.box.fontColor;
            this.g.context.font = `${this.g.box.fontSize} ${this.g.box.fontFamily}`;
            this.g.context.textAlign = this.g.box.align;
            this.g.context.fillText(this.t, this.x, this.y);
            this.g.context.stroke();
        }
    }
    class Container {
        constructor(g, direction, currentX, currentY) {
            this.g = g;
            this.direction = direction;
            this.currentX = currentX;
            this.currentY = currentY;
            this.boxen = new Map();
            this.logger = new Logger();
        }
        box(t) {
            const box = new Box(this.g, this.currentX, this.currentY, t, this);
            this.boxen.set(t, box);
            const bounds = box.calcTextBounds();
            if (this.direction == Direction.Vertical) {
                this.currentY += bounds.h + this.g.container.ySpacing;
            }
            if (this.direction == Direction.Horizontal) {
                this.currentX += bounds.w + this.g.container.xSpacing;
            }
            return box;
        }
        calcBounds() {
            var minX = this.g.canvas.width;
            var maxX = 0;
            var minY = this.g.canvas.height;
            var maxY = 0;
            for (let b of this.boxen.values()) {
                const bbox = b.calcBoxBounds();
                if (minX > bbox.tl.x) {
                    minX = bbox.tl.x;
                }
                if (maxX < bbox.tr.x) {
                    maxX = bbox.tr.x;
                }
                if (minY > bbox.tl.y) {
                    minY = bbox.tl.y;
                }
                if (maxY < bbox.br.y) {
                    maxY = bbox.br.y;
                }
            }
            return new Bounds(this.g, minX, minY, maxY - minY, maxX - minX);
        }
        draw() {
            const bounds = this.calcBounds();
            const scaled = this.g.percentScale(bounds, this.g.container.xPad, this.g.container.yPad);
            this.g.context.beginPath();
            this.g.context.rect(scaled.x, scaled.y, scaled.w, scaled.h);
            this.g.context.fillStyle = this.g.container.fillCollor;
            this.g.context.fill();
            this.g.context.strokeStyle = this.g.container.borderColor;
            this.g.context.stroke();
            for (let b of this.boxen.values()) {
                b.draw();
            }
        }
        lookup(t) {
            return typeof t === 'string'
                ? this.boxen.get(t)
                : t;
        }
    }
    SimpleDiagram.Container = Container;
})(SimpleDiagram || (SimpleDiagram = {}));
//# sourceMappingURL=canvas.js.map