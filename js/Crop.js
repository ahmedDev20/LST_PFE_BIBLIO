var tst, tst2,
    crd_x = 140,
    crd_y = 140,
    img_x = 0,
    img_y = 0,
    pos_x = 0,
    pos_y = 0,
    wo = 0,
    ho = 0,
    w = 0,
    h = 0,
    fact = 1,
    OImg = new Image();

function TElement(id) {
    this.id = id;
    this.elt = (this.id) ? document.getElementById(id) : null;

    function getX() {
        return this.elt.offsetLeft;
    }
    TElement.prototype.getX = getX;


    function getY() {
        return this.elt.offsetTop;
    }
    TElement.prototype.getY = getY;

    function setX(x) {
        return this.elt.style.left = x + "px";
    }
    TElement.prototype.setX = setX;

    function setY(y) {
        return this.elt.style.top = y + "px"
    }
    TElement.prototype.setY = setY;

}

function TEvent() {
    this.x = 0;
    this.y = 0;

    function init(evt) {
        this.evt = (evt) ? evt : window.event; // l'objet événement 
        if (!this.evt) return;
        this.elt = (this.evt.target) ? this.evt.target : this.evt.srcElement; // la source de l'événement 

        this.id = (this.elt) ? this.elt.id : "";

        // Calcul des coordonnées de la souris par rapport au document 

        if (this.evt.pageX || this.evt.pageY) {
            this.x = this.evt.pageX;
            this.y = this.evt.pageY;
        } else if (this.evt.clientX || this.evt.clientY) {
            this.x = this.evt.clientX + document.body.scrollLeft;
            this.y = this.evt.clientY + document.body.scrollTop;
        }
    }
    TEvent.prototype.init = init;

    function stop() {
        this.evt.cancelBubble = true;
        if (this.evt.stopPropagation) this.evt.stopPropagation(); //Annuler l'appel de meme event
    }
    TEvent.prototype.stop = stop;
}

function TDragObject(id) {
    if (!id) return;
    this.base = TElement;

    this.base(id);
    this.elt.obj = this
    this.elt.onmousedown = _startDrag; // When mouse bouton is pressed

    function startDrag(evt) {
        this.elt.style.zIndex = 1; //  Place in front
        this.lastMouseX = evt.x;
        this.lastMouseY = evt.y;
        evt.dragObject = this;

        document.onmousemove = _drag;
        document.onmouseup = _stopDrag;

        if (this.onStartDrag) this.onStartDrag();
    }
    TDragObject.prototype.startDrag = startDrag;

    function stopDrag(evt) {
        this.elt.style.zIndex = 0;
        evt.dragObject = null;
        document.onmousemove = null;
        document.onmouseup = null;

        if (this.onDrop) this.onDrop();
    }
    TDragObject.prototype.stopDrag = stopDrag;

    function drag(evt) {
        dX = this.getX() + evt.x - this.lastMouseX;
        dY = this.getY() + evt.y - this.lastMouseY;

        this.setX(dX);
        this.setY(dY);

        this.lastMouseX = evt.x;
        this.lastMouseY = evt.y;

        if (this.onDrag) this.onDrag();

    }
    TDragObject.prototype.drag = drag;
}
TDragObject.prototype = new TElement();

var _event = new TEvent(); // Objet global pour manipuler l'événement en cours 

function _startDrag(evt) {
    _event.init(evt);
    if (this.obj && this.obj.startDrag) {
        this.obj.startDrag(_event);
    }
}

function _stopDrag(evt) {
    if (_event.dragObject) _event.dragObject.stopDrag(_event);
}

function _drag(evt) {
    _event.init(evt);
    if (_event.dragObject) _event.dragObject.drag(_event);
    return false;
}

function afficherStatus() {
    if (this.id == 'crd') {
        crd_x = this.getX();
        crd_y = this.getY();

    } else if (this.id == 'img') {
        img_x = this.getX();
        img_y = this.getY();
    }
    pos_x = crd_x - img_x;
    pos_y = crd_y - img_y;
    document.getElementById('crd_x').value = crd_x;
    document.getElementById('crd_y').value = crd_y;
    document.getElementById('img_x').value = img_x;
    document.getElementById('img_y').value = img_y;
    document.getElementById('pos_x').value = pos_x;
    document.getElementById('pos_y').value = pos_y;
}

function load() {
    tst = new TDragObject("img");
    tst.onDrag = afficherStatus;

    tst2 = new TDragObject("crd");
    tst2.onDrag = afficherStatus;

    OImg.src = document.getElementById('photo').src;
    wo = OImg.width;
    ho = OImg.height;
}

function ResizeUp() {
    if (fact > 2.0)
        return;
    fact = fact + 0.05;
    document.getElementById('photo').width = parseInt(OImg.width * fact);
    document.getElementById('photo').height = parseInt(OImg.height * fact);
    document.getElementById('ratio').value = fact.toFixed(2);
    console.log('w :' + document.getElementById('photo').width + ' value-w:' + parseInt(wo * fact) + ' h :' + document.getElementById('photo').height + ' r :' + fact.toFixed(2))
}

function ResizeDown() {
    if (fact < 0.1)
        return;
    fact = fact - 0.05;
    document.getElementById('photo').width = parseInt(OImg.width * fact);
    document.getElementById('photo').height = parseInt(OImg.height * fact);
    document.getElementById('ratio').value = fact.toFixed(2); //convert to str
    console.log('w :' + document.getElementById('photo').width + ' value-w:' + parseInt(wo * fact) + ' h :' + document.getElementById('photo').height + ' r :' + fact.toFixed(2))
}

function ChangeColor(color) {
    document.getElementById('crd').style.border = '2px dashed ' + color;
}

function ChangePos() {
    var cod = window.event.keyCode;
    var crd = document.getElementById('crd');

    if (cod == 37) {
        crd_x = tst2.getX() - 1;
        tst2.setX(crd_x);
    } else if (cod == 38) {
        crd_y = tst2.getY() - 1;
        tst2.setY(crd_y);
    } else if (cod == 39) {
        crd_x = tst2.getX() + 1;
        tst2.setX(crd_x);
    } else if (cod == 40) {
        crd_y = tst2.getY() + 1;
        tst2.setY(crd_y);
    }
    afficherStatus();
}

function Crop() {
    document.getElementById('CropForm').submit();
}