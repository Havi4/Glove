// Create the canvas
var oCanvas = document.getElementById("canvas");
var ctx = oCanvas.getContext("2d");
ctx.fillStyle = "#ededed";
ctx.fillRect(0, 0, 1334, 750);
            //平铺

var img = new Image(); //创建
img.src = "images/football_back.png"; //图片地址
img.onload = function() {
	var pat = ctx.createPattern(img, "repeat");
	ctx.fillStyle = pat;
    ctx.fillRect(0, 0, 1334, 750);
}

// Hero image
var heroReady = false;
var heroImage = new Image();
heroImage.onload = function () {
	heroReady = true;
};
heroImage.src = "images/football.png";

// Monster image
var monsterReady = false;
var monsterImage = new Image();
monsterImage.onload = function () {
	monsterReady = true;
};
monsterImage.src = "images/football_door.png";

// Game objects
var hero = {
	speed: 10 // movement in pixels per second//ball
};
var monster = {};//door
var monstersCaught = 0;

// Handle keyboard controls
var keysDown = {};

addEventListener("keydown", function (e) {
	keysDown[e.keyCode] = true;
}, false);

addEventListener("keyup", function (e) {
	delete keysDown[e.keyCode];
}, false);

// Reset the game when the player catches a monster
//ball origin position
hero.x = canvas.width-25;
hero.y = 40;
//door origin position
monster.x = 0;
monster.y = 100;

var reset = function () {
	hero.x = canvas.width / 2;
	hero.y = canvas.height / 2;

	// Throw the monster somewhere on the screen randomly
	monster.x = 32 + (Math.random() * (canvas.width - 64));
	monster.y = 32 + (Math.random() * (canvas.height - 64));
};

var resetHero = function () {
	hero.x = canvas.width-25;
	hero.y = (Math.random() * (canvas.height - 25));
}

// Update game objects
var update = function (modifier) {
	if (38 in keysDown) { // Player holding up
		// monster.y -= hero.speed * modifier;
		var b = GetRandomNum(0,360);
		getBluetoothValue(b);
	}
	if (40 in keysDown) { // Player holding down
		monster.y += hero.speed * modifier;
	}
	hero.x -= hero.speed * modifier;
	// Are they touching?
	if (hero.x<0) {
		resetHero();
	}
	if ((hero.y > (monster.y-25) && hero.x < 5) && (hero.y < (monster.y+25) && hero.x < 5)) {
		++monstersCaught;
		resetHero();
	}
	// if (
	// 	hero.x <= (monster.x + 32)
	// 	&& monster.x <= (hero.x + 32)
	// 	&& hero.y <= (monster.y + 32)
	// 	&& monster.y <= (hero.y + 32)
	// ) {
	// 	++monstersCaught;
	// 	reset();
	// }
};

function GetRandomNum(Min,Max)
{   
	var Range = Max - Min;   
	var Rand = Math.random();   
	return(Min + Math.round(Rand * Range));   
}   

// Draw everything
var render = function () {
	var pat = ctx.createPattern(img, "repeat");
	ctx.fillStyle = pat;
    ctx.fillRect(0, 0, 1334, 750);
	if (heroReady) {
		ctx.drawImage(heroImage, hero.x, hero.y);
	}

	if (monsterReady) {
		ctx.drawImage(monsterImage, monster.x, monster.y);
	}

	// Score
	ctx.fillStyle = "rgb(250, 250, 250)";
	ctx.font = "16px Helvetica";
	ctx.textAlign = "left";
	ctx.textBaseline = "top";
	ctx.fillText("得分: " + monstersCaught, canvas.width-80, 10);
};

function getBluetoothValue(msg) {
    //alert('你好 ' + msg + ', 我也很高兴见到你')
    startMover(msg);
    
}

var timer = null;
function startMover(itarget){//目标值
	 clearInterval(timer);//执行当前动画同时清除之前的动画
	 if (itarget < 0) {
	 	itarget = 0;
	 }

	 if (itarget > 750-50) {
	 	itarget = 750-50;
	 }
	 var oldy = monster.y;
	 if (abs(oldy - itarget) < 10) {
	 	return;
	 }
	 timer = setInterval(function(){
	 var speed = 0;
		 if(oldy > itarget){
		  	speed = -1;
		 }
		 else{
		  	speed = 1;
		 }
		 if(monster.y == itarget){
		  	clearInterval(timer);
		 }
		 else{
		  	monster.y = monster.y+speed;
		 }
	 },0.5);
}

// The main game loop
var main = function () {
	var now = Date.now();
	var delta = now - then;

	update(delta / 100);
	render();

	then = now;

	// Request to do this again ASAP
	requestAnimationFrame(main);
};

// Cross-browser support for requestAnimationFrame
var w = window;
requestAnimationFrame = w.requestAnimationFrame || w.webkitRequestAnimationFrame || w.msRequestAnimationFrame || w.mozRequestAnimationFrame;

// Let's play this game!
var then = Date.now();
main();
