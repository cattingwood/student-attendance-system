
var Div = document.getElementById('toEvaluate');

var disX, moveX, L, T, starX, starY, starXEnd, starYEnd;

Div.addEventListener('touchstart', function (e) {
    //e.preventDefault();

    disX = e.touches[0].clientX - this.offsetLeft;
    disY = e.touches[0].clientY - this.offsetTop;
    starX = e.touches[0].clientX;
    starY = e.touches[0].clientY;
});

Div.addEventListener('ondragstart', function (e) {
    //e.preventDefault();

    disX = e.touches[0].clientX - this.offsetLeft;
    disY = e.touches[0].clientY - this.offsetTop;
    starX = e.touches[0].clientX;
    starY = e.touches[0].clientY;
});

Div.addEventListener('touchmove', function (e) {
    L = e.touches[0].clientX - disX;
    T = e.touches[0].clientY - disY;
    starXEnd = e.touches[0].clientX - starX;
    starYEnd = e.touches[0].clientY - starY;
    if (L < 0) {
        L = 0;
    } else if (L > document.documentElement.clientWidth - this.offsetWidth) {
        L = document.documentElement.clientWidth - this.offsetWidth;
    }

    if (T < 0) {
        T = 0;
    } else if (T > document.documentElement.clientHeight - this.offsetHeight) {
        T = document.documentElement.clientHeight - this.offsetHeight;
    }
    moveX = L + 'px';
    moveY = T + 'px';
    //console.log(moveX);
    this.style.left = moveX;
    this.style.top = moveY;
});

Div.addEventListener('ondrag', function (e) {
    L = e.touches[0].clientX - disX;
    T = e.touches[0].clientY - disY;
    starXEnd = e.touches[0].clientX - starX;
    starYEnd = e.touches[0].clientY - starY;
    if (L < 0) {
        L = 0;
    } else if (L > document.documentElement.clientWidth - this.offsetWidth) {
        L = document.documentElement.clientWidth - this.offsetWidth;
    }

    if (T < 0) {
        T = 0;
    } else if (T > document.documentElement.clientHeight - this.offsetHeight) {
        T = document.documentElement.clientHeight - this.offsetHeight;
    }
    moveX = L + 'px';
    moveY = T + 'px';
    //console.log(moveX);
    this.style.left = moveX;
    this.style.top = moveY;
});

Div.addEventListener('touchend', function (e) {
    if (L > (document.body.clientWidth / 2)  || ((careDiv.style.right == '' || careDiv.style.right == '0px') && !L)) {
        Div.style.left = 'auto';
        Div.style.right = '.4rem';
    } else {
        Div.style.left = '.4rem';
        Div.style.right = 'auto';
    }
});

Div.addEventListener('ondragend', function (e) {
    if (L > (document.body.clientWidth / 2)  || ((careDiv.style.right == '' || careDiv.style.right == '0px') && !L)) {
        Div.style.left = 'auto';
        Div.style.right = '.4rem';
    } else {
        Div.style.left = '.4rem';
        Div.style.right = 'auto';
    }
});