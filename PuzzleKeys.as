package 
{

	import flash.events.*;
	import flash.display.*;
	import flash.media.Sound;
	import flash.net.URLRequest;
	import fl.controls.Button;

	public class PuzzleKeys
	{
		//var musica:Sound = new Sound();
		
		
		var ganhei:int =0;
		var linhasnum:int = 0;
		var linhaactiva:MovieClip;
		var linhas;
		var pontos;
		var orix;
		var oriy;
		var linhaselected:Boolean
		var linha:MovieClip;
		var myStage:Stage;
		var Dot1:MovieClip;
		//array das linhas
		var alinhas:Array = new Array();
		var dots:Array;
		var pontoselected;
		var dotguardadas:Array = new Array();
		var nlinhascertas = 0;
		var nlinhaserradas = 0;
		var checkBT : SimpleButton;
		var myTimeline : MovieClip;
		
		//por a primeira linha invisivel
		public function PuzzleKeys(checkBT:SimpleButton, myTimeline : MovieClip,linha : MovieClip, myStage : Stage, dots:Array)
		{
			this.myTimeline = myTimeline;
			this.linha = linha;
			this.checkBT = checkBT;
			this.myStage = myStage;
			this.dots = new Array;
			for(var i=0;i<dots.length;i++){
				this.dots[i] = dots[i];
			}
			linha.alpha = 0;
			linhaselected = false;
			
			for(var j=0;j<dots.length;j++){
				dots[j].addEventListener(MouseEvent.MOUSE_UP,Colponto_Mouse);
				dots[j].addEventListener(TouchEvent.TOUCH_TAP,Colponto_Touch);
			}
			
			checkBT.mouseEnabled = false;
			//musica.load(new URLRequest("Machi, Toki no Nagare, Hito (Town, Flow of Time, People).mp3"));
			//musica.play();
		}
		
		function Colponto_Mouse(e : MouseEvent):void
		{
			for (var i=0;i<dots.length;i++)
			{					
					
					var alinhas;
					//vai buscar a posição do rato
					orix = e.stageX;
					oriy = e.stageY;
					if(linhaselected){
						var aux;
						for(var q=0;q<dots.length;q++){
							if(e.target == dots[q]){
								aux = q+1;
							}
						}
						if(pontoselected!= aux){
							linhaactiva.height = Math.sqrt(Math.pow(linhaactiva.x - e.stageX,2) + Math.pow(linhaactiva.y - e.stageY,2));
							//caso 3
							if((linhaactiva.y<	e.stageY) &&(linhaactiva.x>e.stageX)){
								linhaactiva.rotation =  90 - (180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((e.stageX - linhaactiva.x))));
							}
							//caso 1
							else if((e.stageX > linhaactiva.x) &&(e.stageY<linhaactiva.y)){
								linhaactiva.rotation =  -(180-(180-(90+(180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((linhaactiva.x -	e.stageX)))))));
							}
							//caso 4
							else if((e.stageY>linhaactiva.y)){
								linhaactiva.rotation= -(180-(90+(180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((linhaactiva.x -	e.stageX))))));
							}
							//caso 2
							else if(e.stageY<linhaactiva.y){
								linhaactiva.rotation =  180- (90 - (180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((e.stageX - linhaactiva.x)))));
							}
							
						
							alinhas = new Linha;
							myStage.addChild(alinhas);
							alinhas.height = 3;
							alinhas.x = orix;
							alinhas.y = oriy;
							dotguardadas.push(alinhas);
							
							linhaactiva = alinhas;
						
						
							if(nlinhascertas == 0 &&(pontoselected == 1 && aux == 4 )){
								nlinhascertas++;
							}
							else if(nlinhascertas ==1 && (pontoselected == 4 && aux == 7 )){
								nlinhascertas++;
							}
							else if(nlinhascertas ==2 && (pontoselected == 7 && aux == 1 )){
								nlinhascertas++;
							}
							else if(nlinhascertas ==3 && (pontoselected == 1 && aux == 11 )){
								nlinhascertas++;
								trace("ganhei");
								ganhei = 1;
								//dotguardadas = new Array;
								nlinhaserradas = 0;
								nlinhascertas = 0;
								linhaselected = false;
								pontoselected = null;
								checkBT.mouseEnabled = true;
								checkBT.addEventListener(MouseEvent.MOUSE_UP,Out);
								checkBT.addEventListener(TouchEvent.TOUCH_TAP,Out);
								break;
								}
							else {
								nlinhaserradas++;
							}
							
							
						if((nlinhaserradas>=4) || (nlinhascertas + nlinhaserradas>4)){
							trace("perdeste");
							trace(dotguardadas);
							for(i=0;i<dotguardadas.length;i++){
								trace(dotguardadas.length);
								myStage.removeChild(dotguardadas[i]);
							}
							dotguardadas = new Array;
							nlinhaserradas = 0;
							nlinhascertas = 0;
							linhaselected = false;
							pontoselected = null;
							break;
						}
					
						pontoselected = aux;
							}
						}
						else{
						
							linhaselected = true;
							for(var k=0;k<dots.length;k++){
								if(e.target == dots[k]){
									pontoselected = k+1;
									trace(pontoselected);
								}
							}
						
						trace(pontoselected);
						//duplicar a linha
						alinhas = new Linha;
						if (ganhei==1){
							for(var j=0;j<dots.length;j++){
								dots[j].removeEventListener(MouseEvent.MOUSE_DOWN,Colponto_Mouse);														
							}
						}
						else{
							
						myStage.addChild(alinhas);
						
						alinhas.height = 3;
						alinhas.x = orix;
						alinhas.y = oriy;
						linhaactiva = alinhas;
						dotguardadas.push(linhaactiva);
						trace(linhaactiva);
						break;
						}
					}
				}
			}
			
			function Colponto_Touch(e : TouchEvent):void
		{
			for (var i=0;i<dots.length;i++)
			{					
					
					var alinhas;
					//vai buscar a posição do rato
					orix = e.stageX;
					oriy = e.stageY;
					if(linhaselected){
						var aux;
						for(var q=0;q<dots.length;q++){
							if(e.target == dots[q]){
								aux = q+1;
							}
						}
						if(pontoselected!= aux){
							linhaactiva.height = Math.sqrt(Math.pow(linhaactiva.x - e.stageX,2) + Math.pow(linhaactiva.y - e.stageY,2));
							//caso 3
							if((linhaactiva.y<	e.stageY) &&(linhaactiva.x>e.stageX)){
								linhaactiva.rotation =  90 - (180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((e.stageX - linhaactiva.x))));
							}
							//caso 1
							else if((e.stageX > linhaactiva.x) &&(e.stageY<linhaactiva.y)){
								linhaactiva.rotation =  -(180-(180-(90+(180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((linhaactiva.x -	e.stageX)))))));
							}
							//caso 4
							else if((e.stageY>linhaactiva.y)){
								linhaactiva.rotation= -(180-(90+(180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((linhaactiva.x -	e.stageX))))));
							}
							//caso 2
							else if(e.stageY<linhaactiva.y){
								linhaactiva.rotation =  180- (90 - (180/Math.PI *Math.atan(Math.abs((linhaactiva.y - e.stageY)) / Math.abs((e.stageX - linhaactiva.x)))));
							}
							
						
							alinhas = new Linha;
							myStage.addChild(alinhas);
							alinhas.height = 3;
							alinhas.x = orix;
							alinhas.y = oriy;
							dotguardadas.push(alinhas);
							
							linhaactiva = alinhas;
						
						
							if(nlinhascertas == 0 &&(pontoselected == 1 && aux == 4 )){
								nlinhascertas++;
							}
							else if(nlinhascertas ==1 && (pontoselected == 4 && aux == 7 )){
								nlinhascertas++;
							}
							else if(nlinhascertas ==2 && (pontoselected == 7 && aux == 1 )){
								nlinhascertas++;
							}
							else if(nlinhascertas ==3 && (pontoselected == 1 && aux == 11 )){
								nlinhascertas++;
								trace("ganhei");
								ganhei = 1;
								//dotguardadas = new Array;
								nlinhaserradas = 0;
								nlinhascertas = 0;
								linhaselected = false;
								pontoselected = null;
								break;
								}
							else {
								nlinhaserradas++;
							}
							
							
						if((nlinhaserradas>=4) || (nlinhascertas + nlinhaserradas>4)){
							trace("perdeste");
							trace(dotguardadas);
							for(i=0;i<dotguardadas.length;i++){
								trace(dotguardadas.length);
								myStage.removeChild(dotguardadas[i]);
							}
							dotguardadas = new Array;
							nlinhaserradas = 0;
							nlinhascertas = 0;
							linhaselected = false;
							pontoselected = null;
							break;
						}
					
						pontoselected = aux;
							}
						}
						else{
						
							linhaselected = true;
							for(var k=0;k<dots.length;k++){
								if(e.target == dots[k]){
									pontoselected = k+1;
									trace(pontoselected);
								}
							}
						
						trace(pontoselected);
						//duplicar a linha
						alinhas = new Linha;
						if (ganhei==1){
							for(var j=0;j<dots.length;j++){
								dots[j].removeEventListener(TouchEvent.TOUCH_TAP,Colponto_Touch);
							}
						}
						else{
							
						myStage.addChild(alinhas);
						
						alinhas.height = 3;
						alinhas.x = orix;
						alinhas.y = oriy;
						linhaactiva = alinhas;
						dotguardadas.push(linhaactiva);
						trace(linhaactiva);
						break;
						}
					}
				}
			}
			
			function Out(e : Event) : void{
				checkBT.removeEventListener(MouseEvent.MOUSE_UP,Out);
				checkBT.removeEventListener(TouchEvent.TOUCH_TAP,Out);
				trace(dotguardadas.length);
				for(var i=0;i<dotguardadas.length;i++){
								trace(dotguardadas.length);
								myStage.removeChild(dotguardadas[i]);
				}
				myTimeline.gotoAndStop(29);
			}
		}
	}
