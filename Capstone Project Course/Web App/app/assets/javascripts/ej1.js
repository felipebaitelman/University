var ej1 = (function() {
	var canv = document.getElementById('breath1');

	if(canv!=null && canv.getContext)
	{
		//Posicion aditiva de cada circulo
		var posX = [0,80,160,240,
					320,320,320,320,
					320,240,160,80,
					0,0,0,0];

		var posY = [0,0,0,0,
					0,80,160,240,
					320,320,320,320,
					320,240,160,80];

		//Tamaño de cada circulo;
		var bigSize = 40;
		var smallSize = 10;

		var sizes = [bigSize,smallSize,smallSize,smallSize,
					bigSize,smallSize,smallSize,smallSize,
					bigSize,smallSize,smallSize,smallSize,
					bigSize,smallSize,smallSize,smallSize];

		//Posicion inicial de cada circulo, posicion absoluta = posicion inicial + posicion aditiva
		var xIni = 90;
		var yIni = 90;

		//Color inicial de los circulos
		var startColorR = 255.0;
		var startColorG = 255.0;
		var startColorB = 255.0;

		//Tiempo de actualizacion para poder cambiar el color de los circulos
		var interTime = 1000.0/60.0;
		//Cuanto tiempo tarda un circulo en pasar del color inicial al final
		var deltaTime = 6000;
		//Indice del ultimo circulo pintado
		var currentIndex = 12;
		//Tiempo Actual
		var startTime = new Date().getTime();

		//Colores de los circulos
		var circleColorR = [startColorR,startColorR,startColorR,startColorR,
							startColorR,startColorR,startColorR,startColorR,
							startColorR,startColorR,startColorR,startColorR,
							startColorR,startColorR,startColorR,startColorR];

		var circleColorG = [startColorG,startColorG,startColorG,startColorG,
							startColorG,startColorG,startColorG,startColorG,
							startColorG,startColorG,startColorG,startColorG,
							startColorG,startColorG,startColorG,startColorG];

		var circleColorB = [startColorB,startColorB,startColorB,startColorB,
							startColorB,startColorB,startColorB,startColorB,
							startColorB,startColorB,startColorB,startColorB,
							startColorB,startColorB,startColorB,startColorB];

		//Tiempo de cada circulo
		var circleTime = [0,0,0,0,
							0,0,0,0,
							0,0,0,0,
							0,0,0,0];

		//Color al que cambian los circulos al ser pintados.
		var MaxColorR = 12.0;
		var MaxColorG = 12.0;
		var MaxColorB = 12.0;

		//Textos posibles
		var textIndex = 3;
		var textos = ["Inhala","Mantén","Exhala","Mantén"];

		//Fuente del texto
		var f = "30px Helvetica Neue";
		var fontR = 255;
		var fontG = 255;
		var fontB = 255;
		
		var ctx = canv.getContext("2d");

		setInterval(function()
		{ 


				ctx.beginPath();
				ctx.clearRect(0, 0, canv.width, canv.height);
				ctx.closePath();

				var scaleX = canv.width/500;

				var scaleY = canv.height/500;

				var scaleColor = 0.0;

				var r = 0;
				var g = 0;
				var b = 0;

				var endTime = new Date().getTime();

				if(endTime - startTime>=1000)
				{

					if(currentIndex%textos.length == 0)
					{
						textIndex = (textIndex+1)%textos.length;
					}

					startTime = new Date().getTime();
					circleTime[currentIndex] = startTime;
					currentIndex = (currentIndex+1)%sizes.length;
				}

				ctx.beginPath();		
				ctx.font = f;
				ctx.fillStyle = "rgb("+fontR+","+fontG+","+fontB+")";
				ctx.textAlign = "center";
				ctx.fillText(textos[textIndex], canv.width/2, canv.height/2);
				ctx.closePath();

				for (var i = 0; i < sizes.length; i++)
				{

					scaleColor = (endTime-circleTime[i])/deltaTime;

					if(scaleColor>1)scaleColor=1.0;

					r = Math.round(((startColorR-MaxColorR)*scaleColor) + MaxColorR);

					g = Math.round(((startColorG-MaxColorG)*scaleColor) + MaxColorG);

					b = Math.round(((startColorB-MaxColorB)*scaleColor) + MaxColorB);

					ctx.beginPath();
					ctx.arc((xIni+posX[i])*scaleX,(yIni+posY[i])*scaleY,sizes[i]*scaleX,0,
							2*Math.PI,false);

					ctx.fillStyle = "rgba("+r+","+g+","+b+", 0.3)";
					ctx.fill();


					ctx.closePath();

					circleColorR[i] = r;
					circleColorG[i] = g;
					circleColorB[i] = b;
				}		
		}
		, interTime);
	}
});

$(document).on('turbolinks:load', ej1);
