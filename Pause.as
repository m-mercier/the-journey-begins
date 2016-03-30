package  {
	import flash.events.*;
	import flash.display.*;
	import flash.net.*;
	import flash.filesystem.*;
	import fl.controls.Button;
	
	public class Pause extends MovieClip{
		var myStage : Stage;
		var bckg : PauseBackG; 
		var pauseBts : Array;
		var pauseBT : PauseBT;
		var MainTimeline : MovieClip;
		var saveSlotsImg : Array;
		var saveSlots : Array;
		var savedSlots : Array;
		var back : BTBack = new BTBack();
		
		
		public function Pause(myStage : Stage, pauseBT : PauseBT, MainTimeline : MovieClip, SSlots : Array){
			this.myStage = myStage;
			bckg = new PauseBackG();
			pauseBts = new Array();
			this.pauseBT = pauseBT;
			this.MainTimeline = MainTimeline;
			saveSlotsImg = new Array();
			saveSlots = SSlots;
			savedSlots = new Array(new SavedSlot1, new SavedSlot2, new SavedSlot3);
		}
		
		public function startPause(){
			addEventListener("exit", resumeGame2);
			removePause();
			loadBack();
			loadButtons();
			btsInit();
		}
		
		private function removePause(){
			pauseBT.removeEventListener(TouchEvent.TOUCH_TAP, pauseHandler);
			pauseBT.removeEventListener(MouseEvent.MOUSE_UP, pauseHandler);
			pauseBT.parent.removeChild(pauseBT);
			
		}
		
		private function loadBack() : void{			
			myStage.addChild(bckg);
		}
		
		private function loadButtons() : void{
			pauseBts.length = 0;
			
			pauseBts.push(new PBT_Resume());
			pauseBts.push(new PBT_Save());
			pauseBts.push(new PBT_Options());
			
			var menuBT : PBT_MainMenu = new PBT_MainMenu();
			pauseBts.push(menuBT);
			
			addToStage();
		}
		
		private function addToStage() : void{
			for (var i = 0; i < pauseBts.length; i++){
				myStage.addChild(pauseBts[i]);
				pauseBts[i].x = (myStage.stageWidth - pauseBts[i].width) * 0.5;
				pauseBts[i].y = 380 + i*70;
			}
		}
		
		private function btsInit() : void{
			for (var i = 0; i < pauseBts.length; i++){
				pauseBts[i].name = i;
				trace(pauseBts[i].name);
				pauseBts[i].addEventListener(TouchEvent.TOUCH_TAP, btHandler);
				pauseBts[i].addEventListener(MouseEvent.MOUSE_UP, btHandler);
			}
		}
		
		private function btHandler(e : Event) : void{
			
			e.target.removeEventListener(TouchEvent.TOUCH_TAP, btHandler);
			e.target.removeEventListener(MouseEvent.MOUSE_UP, btHandler);
			
			var button : String = e.target.name;
			
			switch(button){
				case "0":
					addPause();
					resumeGame();
					break;
				case "1":
					save();
					break;
				case "2":
					resumeGame();
					myStage.dispatchEvent(new Event("removeBt"));
					dispatchEvent(new Event("fromPause"));
					MainTimeline.gotoAndStop(3);
					break;
				case "3":
					resumeGame();
					myStage.dispatchEvent(new Event("removeBt"));
					MainTimeline.gotoAndStop(1);
					break;
			}
		}
		
		private function save() : void{
			for (var i = 0; i < pauseBts.length; i++){
				myStage.removeChild(pauseBts[i]);
			}
			
			saveSlotsImg.length = 0;
			saveSlotsImg.push(new SaveTest());
			saveSlotsImg.push(new SaveSlot2());
			saveSlotsImg.push(new SaveSlot3());
			
			for (i = 0; i < saveSlotsImg.length; i++){
				myStage.addChild(saveSlotsImg[i]);
			}
			arrangeSlots();
			
			myStage.addChild(back);
			back.x = 900;
			back.y = 610;
			back.width = 100;
			back.height = 42;
			back.addEventListener(MouseEvent.MOUSE_UP, backToPause);
			back.addEventListener(TouchEvent.TOUCH_TAP, backToPause);
			
			
			saveSlotsImg[0].addEventListener(TouchEvent.TOUCH_TAP, SaveGame1);
			saveSlotsImg[0].addEventListener(MouseEvent.MOUSE_UP, SaveGame1);
			saveSlotsImg[1].addEventListener(TouchEvent.TOUCH_TAP, SaveGame2);
			saveSlotsImg[1].addEventListener(MouseEvent.MOUSE_UP, SaveGame2);
			saveSlotsImg[2].addEventListener(TouchEvent.TOUCH_TAP, SaveGame3);
			saveSlotsImg[2].addEventListener(MouseEvent.MOUSE_UP, SaveGame3);
			
		}
		
		private function backToPause(e : Event) : void{
			back.removeEventListener(MouseEvent.MOUSE_UP, backToPause);
			back.removeEventListener(TouchEvent.TOUCH_TAP, backToPause);
			myStage.removeChild(back);
			for (var i = 0; i < saveSlotsImg.length; i++){
				myStage.removeChild(saveSlotsImg[i]);
			}
			loadButtons();
			btsInit();
		}
		
		private function arrangeSlots() : void{
			trace("arrange slots");
			for (var i = 0; i < saveSlotsImg.length; i++){
				//saveSlots[i].width = 80;
				//saveSlots[i].height = 80;
				saveSlotsImg[i].x = (myStage.stageWidth - saveSlotsImg[i].width) * 0.5;
				saveSlotsImg[i].y = 360 + i*100;
			}
			
		}
		
		private function SaveGame1(e : Event) : void{
			saveSlotsImg[0].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame1);
			saveSlotsImg[0].removeEventListener(MouseEvent.MOUSE_UP, SaveGame1);
			saveSlotsImg[1].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame2);
			saveSlotsImg[1].removeEventListener(MouseEvent.MOUSE_UP, SaveGame2);
			saveSlotsImg[2].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame3);
			saveSlotsImg[2].removeEventListener(MouseEvent.MOUSE_UP, SaveGame3);
			
			saveSlots[0].data.slot = 1;
			saveSlots[0].data.lastFrame = MainTimeline.currentFrame;
			trace("Saved frame: " + saveSlots[0].data.lastFrame);
			saveSlots[0].flush();
			confirmSave(0);
		}
		
		private function SaveGame2(e : Event) : void{
			saveSlotsImg[0].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame1);
			saveSlotsImg[0].removeEventListener(MouseEvent.MOUSE_UP, SaveGame1);
			saveSlotsImg[1].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame2);
			saveSlotsImg[1].removeEventListener(MouseEvent.MOUSE_UP, SaveGame2);
			saveSlotsImg[2].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame3);
			saveSlotsImg[2].removeEventListener(MouseEvent.MOUSE_UP, SaveGame3);
			
			saveSlots[1].data.slot = 2;
			saveSlots[1].data.lastFrame = MainTimeline.currentFrame;
			saveSlots[1].flush();
			confirmSave(1);
		}
		
		private function SaveGame3(e : Event) : void{
			saveSlotsImg[0].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame1);
			saveSlotsImg[0].removeEventListener(MouseEvent.MOUSE_UP, SaveGame1);
			saveSlotsImg[1].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame2);
			saveSlotsImg[1].removeEventListener(MouseEvent.MOUSE_UP, SaveGame2);
			saveSlotsImg[2].removeEventListener(TouchEvent.TOUCH_TAP, SaveGame3);
			saveSlotsImg[2].removeEventListener(MouseEvent.MOUSE_UP, SaveGame3);
			
			saveSlots[2].data.slot = 3;
			saveSlots[2].data.lastFrame = MainTimeline.currentFrame;
			saveSlots[2].flush();
			confirmSave(2);
		}
		
		private function confirmSave(slotIndex : int) : void{
			var savedX = saveSlotsImg[slotIndex].x;
			var savedY = saveSlotsImg[slotIndex].y;
			var savedWidth = saveSlotsImg[slotIndex].width;
			var savedHeight = saveSlotsImg[slotIndex].height;
			myStage.removeChild(saveSlotsImg[slotIndex]);
			saveSlotsImg[slotIndex] = savedSlots[slotIndex];
			myStage.addChild(saveSlotsImg[slotIndex]);			
			saveSlotsImg[slotIndex].x = savedX;
			saveSlotsImg[slotIndex].y = savedY;
			saveSlotsImg[slotIndex].width = savedWidth;
			saveSlotsImg[slotIndex].height = savedHeight;
		}
		
		private function addPause() : void{
			pauseBT = new PauseBT();
			pauseBT.x = 1090,10;
			pauseBT.y = -8,65;
			pauseBT.width = 208,05;
			pauseBT.height = 154,50;
			MainTimeline.addChild(pauseBT);
			pauseBT.addEventListener(TouchEvent.TOUCH_TAP, pauseHandler);
			pauseBT.addEventListener(MouseEvent.MOUSE_UP, pauseHandler);
		}
		
		private function resumeGame() : void{
			myStage.removeChild(bckg)
			for (var i = 0; i < pauseBts.length; i++)
				myStage.removeChild(pauseBts[i]);
			pauseBts.length = 0;
		}
		
		private function resumeGame2(e : Event) : void{
			trace("resume2");
			myStage.removeChild(bckg)
			for (var i = 0; i < pauseBts.length; i++)
				myStage.removeChild(pauseBts[i]);
			pauseBts.length = 0;
		}
		
		private function pauseHandler(e: Event) {
			trace("pauseHandler");
			
			if(myStage){
				startPause();
			}
			else{
				addEventListener(Event.ADDED_TO_STAGE, startPause);
			}
}
	}
}
