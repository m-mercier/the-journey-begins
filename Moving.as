package  {
	
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	import flash.filesystem.*;
	import fl.controls.Button;
	import flash.utils.*;
	
	public class Moving {
			var moveBT : BTMove;
			var newArrow : BTArrow;
			var myStage : Stage;
			var MainTimeline : MovieClip;
			var side : String;
			
		public function Moving(myStage : Stage, MainTimeline : MovieClip, side : String) {
			moveBT = new BTMove();
			newArrow = new BTArrow();
			this.myStage = myStage;
			this.MainTimeline = MainTimeline;
			this.side = side;
			trace("New Moving");
		}
		
		public function addMoveFeatures() : void{
			myStage.addChild(moveBT);
			arrangeBT();
			
		}
		
		private function arrangeBT() : void{
			moveBT.x = myStage.stageWidth - moveBT.width;
			moveBT.y = myStage.stageHeight - moveBT.height;
			moveBT.addEventListener(TouchEvent.TOUCH_TAP, addArrow);
			moveBT.addEventListener(MouseEvent.MOUSE_UP, addArrow);
		}
		
		private function addArrow(e : Event) : void{
			moveBT.removeEventListener(TouchEvent.TOUCH_TAP, addArrow);
			moveBT.removeEventListener(MouseEvent.MOUSE_UP, addArrow);
			myStage.removeChild(moveBT);
			myStage.addChild(newArrow)
			arrangeArrow();
		}
		
		private function arrangeArrow() : void{
			newArrow.width = 85;
			newArrow.height = 52;
			switch(side){
				case "up":
					newArrow.rotation = 180;
					newArrow.x = (myStage.width - newArrow.width) * 0.5;
					newArrow.y = 60;
					break;
				case "down":
					newArrow.x = (myStage.width - newArrow.width) * 0.5;
					newArrow.y = 680;
					break;
				case "left":
					newArrow.rotation = 90;
					newArrow.x = 60;
					newArrow.y = (myStage.height - newArrow.height) * 0.5;
					break;
				case "down":
					newArrow.rotation = 270;
					newArrow.x = 1220;
					newArrow.y = (myStage.height - newArrow.height) * 0.5;
					break;
			}
			newArrow.addEventListener(TouchEvent.TOUCH_TAP, gotoFrame);
			newArrow.addEventListener(MouseEvent.MOUSE_UP, gotoFrame);
		}
		
		private function gotoFrame(e : Event) : void{
			newArrow.removeEventListener(TouchEvent.TOUCH_TAP, gotoFrame);
			newArrow.removeEventListener(MouseEvent.MOUSE_UP, gotoFrame);
			myStage.removeChild(newArrow);
			MainTimeline.nextFrame();
		}

	}
	
}
