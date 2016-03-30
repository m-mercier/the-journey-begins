package  {
	import flash.events.*;
	import flash.display.*;
	import fl.controls.Button;

	
	public class PaperPuzzle {
		var pieces : Array;
		var targets = Array;
		
		var xPos : int;
		var yPos : int;
		
		var myStage : Stage;
		
		var TestBT : SimpleButton;
		
		var myTimeline : MovieClip;

		public function PaperPuzzle(myTimeline : MovieClip, myStage : Stage, pieces : Array, targets : Array, TestBT : SimpleButton) {
			this.pieces = pieces;
			this.targets = targets;
			this.myStage = myStage;
			this.TestBT = TestBT;
			this.myTimeline = myTimeline;
		}
		
		private function getPosition(target:Object):void
		{
			xPos = target.x;
			yPos = target.y;
		}
		
		private function dragObject(e : MouseEvent) : void{
			getPosition(e.target);
			
			e.target.startDrag();
		}
		
		private function dragObjectTouch(e : TouchEvent) : void{
			getPosition(e.target);
			
			e.target.startTouchDrag(e.touchPointID, false, e.target); 
		}
		
		private function stopDragObject(e : MouseEvent) : void{
			 
			e.target.stopDrag();
		}
		
		private function stopDragObjectTouch(e : TouchEvent) : void{
			
			e.target.stopTouchDrag(e.touchPointID); 
		}
		
		public function init() : void{
			
			for (var i = 0; i < pieces.length; i++){
				
				do{
					xPos = Math.random()*(myStage.width - pieces[i].width);
					yPos = Math.random()*(myStage.height - pieces[i].height);
				}while(xPos >= TestBT.x && xPos <= (TestBT.x + TestBT.width) && yPos >= TestBT.y && yPos <= (TestBT.y + TestBT.height));
				
				pieces[i].x = xPos;
				pieces[i].y = yPos;
				
				pieces[i].addEventListener(MouseEvent.MOUSE_DOWN, dragObject);
				pieces[i].addEventListener(MouseEvent.MOUSE_UP, stopDragObject);
				pieces[i].addEventListener(TouchEvent.TOUCH_BEGIN, dragObjectTouch); 
				pieces[i].addEventListener(TouchEvent.TOUCH_END, stopDragObjectTouch); 
			}
			TestBT.addEventListener(MouseEvent.MOUSE_UP, testar);
			TestBT.addEventListener(TouchEvent.TOUCH_TAP, testar);
		}
		
		private function testar(e: Event) : void{
			var count : int = 0;
			var gap : int = 150;
			trace(pieces.length);
			for (var i = 0; i < pieces.length; i++){
				
				trace("i" + i);
				
				if(targets[i].x < pieces[i].x + gap / 2 && targets[i].x > pieces[i].x - gap / 2 && targets[i].y < pieces[i].y + gap / 2 && targets[i].y  > pieces[i].y - gap / 2){
					count++;
				}
				trace(count);
			}
			
			if(count == pieces.length){
				myTimeline.nextFrame();
			}
		}

	}
	
}
