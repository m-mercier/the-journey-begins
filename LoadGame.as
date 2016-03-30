package  {
	import flash.display.*;
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.net.*;
	import flash.filesystem.*;
	import fl.controls.Button;
	
	public class LoadGame {
			var player : String;
			var lastFrame : int;
			var myStage : Stage;
			var MainTimeline : MovieClip;
			var loadSlotsImg : Array;
			var loadSlots : Array;
			var menuBG : MenuBackG;
			
		public function LoadGame(s : Stage, mt : MovieClip, ls : Array) {
			myStage = s;
			this.MainTimeline = mt;
			loadSlotsImg = new Array();
			loadSlots = ls;
			menuBG = new MenuBackG();
		}
		
		public function initLoad() : void{
			myStage.addChild(menuBG);
			menuBG.x = 0;
			menuBG.y = 0;
			
			var loadSlotsImgs : Array = new Array();
			loadSlotsImg.push(new SaveTest);
			loadSlotsImg.push(new SaveSlot2);
			loadSlotsImg.push(new SaveSlot3);
			
			for(var i = 0; i < loadSlotsImg.length; i++){
				myStage.addChild(loadSlotsImg[i]);
			}
			
			initSlotsImg();
			
		}
		
		private function initSlotsImg() : void{
			for (var i = 0; i < loadSlotsImg.length; i++){
				loadSlotsImg[i].x = (myStage.stageWidth - loadSlotsImg[i].width) * 0.5;
				loadSlotsImg[i].y = 306 + i*100;
			}
			
			loadSlotsImg[0].addEventListener(MouseEvent.MOUSE_UP, loadSlot1);
			loadSlotsImg[0].addEventListener(TouchEvent.TOUCH_TAP, loadSlot1);
			
			loadSlotsImg[1].addEventListener(MouseEvent.MOUSE_UP, loadSlot2);
			loadSlotsImg[1].addEventListener(TouchEvent.TOUCH_TAP, loadSlot2);
			
			loadSlotsImg[2].addEventListener(MouseEvent.MOUSE_UP, loadSlot3);
			loadSlotsImg[2].addEventListener(TouchEvent.TOUCH_TAP, loadSlot3);
		}
		
		private function loadSlot1(e : Event) : void{
			loadG(0);
		}
		
		private function loadSlot2(e : Event) : void{
			loadG(1);
		}
		
		private function loadSlot3(e : Event) : void{
			loadG(2);
		}
		
		public function loadG(slotIndex : int){
			loadSlotsImg[0].removeEventListener(MouseEvent.MOUSE_UP, loadSlot1);
			loadSlotsImg[0].removeEventListener(TouchEvent.TOUCH_TAP, loadSlot1);
			
			loadSlotsImg[1].removeEventListener(MouseEvent.MOUSE_UP, loadSlot2);
			loadSlotsImg[1].removeEventListener(TouchEvent.TOUCH_TAP, loadSlot2);
			
			loadSlotsImg[2].removeEventListener(MouseEvent.MOUSE_UP, loadSlot3);
			loadSlotsImg[2].removeEventListener(TouchEvent.TOUCH_TAP, loadSlot3);
			
			clearLoadStage();
			
			var frameToGo : int = loadSlots[slotIndex].data.lastFrame;
			
			MainTimeline.gotoAndStop(frameToGo);
		}
		
		private function clearLoadStage() : void{
			menuBG.parent.removeChild(menuBG);
			
			for (var i = 0; i < loadSlotsImg.length; i++){
				loadSlotsImg[i].parent.removeChild(loadSlotsImg[i]);
			}
		}

	}
	
}
