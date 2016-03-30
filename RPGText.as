package  {
	import flash.events.*;
	import flash.display.MovieClip;
	import flash.display.Stage;

	public class RPGText extends MovieClip{
		private const SPEAKER : int = 0;
		private const CHAR_LEFT : int = 1;
		private const CHAR_RIGHT : int = 3;
		private const COOPER : int = 2;
		private const TEXT : int = 4;
		private var _currentTextBlockIndex : int = 0;
		private var _currentTextBlock : String;
		private var _textBlocks : Array;
		private var bt_next : BTNext = new BTNext();
		private var bt_end : BTEnd = new BTEnd();
		private var MainTimeline : MovieClip;

		public function RPGText() {
			bt_next.name = "bt_next";
			bt_end.name = "bt_end";
		}
		
		public function set timeline(MainTimeline : MovieClip) : void{
			this.MainTimeline = MainTimeline;
		}
		
		public function set textBlocks(txt : Array) : void{
			_textBlocks = txt;
		}
		
		public function startText() : void{
			_currentTextBlock = _textBlocks[_currentTextBlockIndex][TEXT];
			characterName.gotoAndStop(_textBlocks[_currentTextBlockIndex][SPEAKER]);
			CharacterLeftMain.gotoAndStop(_textBlocks[_currentTextBlockIndex][CHAR_LEFT]);
			CharacterRightMain.gotoAndStop(_textBlocks[_currentTextBlockIndex][CHAR_RIGHT]);			
			if (_textBlocks.length > 1){
				addNextBT();
			}
			else{
				addEndBT();
			}
			addEventListener(Event.ENTER_FRAME, updateText);
		}
		
		private function addNextBT(){
			stage.addChild(bt_next);
			bt_next.x = stage.width - 4.3*bt_next.width;
			bt_next.y = stage.stageHeight - bt_next.height - 0.5*bt_next.height;
			bt_next.addEventListener(TouchEvent.TOUCH_TAP, fillText);
			bt_next.addEventListener(MouseEvent.MOUSE_UP, fillText);
			stage.addEventListener("removeBt", removeBtNext);
		}
		
		private function removeBtNext(e : Event) : void{
			bt_next.visible = false;
		}
		
		private function removeBtEnd(e : Event) : void{
			bt_end.visible = false;
		}
		
		private function addEndBT(){
			bt_end.x = stage.width - 5*bt_end.width;
			bt_end.y = stage.stageHeight - bt_end.height - 0.5*bt_end.height;
			stage.addChild(bt_end);
			bt_end.addEventListener(TouchEvent.TOUCH_TAP, endHandler);
			bt_end.addEventListener(MouseEvent.MOUSE_UP, endHandler);
			stage.addEventListener("removeBt", removeBtEnd);
		}
		
		private function endHandler(e : Event) : void{
			bt_end.removeEventListener(TouchEvent.TOUCH_TAP, endHandler);
			bt_end.removeEventListener(MouseEvent.MOUSE_UP, endHandler);
			stage.removeChild(bt_end);
			MainTimeline.nextFrame();
		}
		
		private function updateText(e : Event) : void{
			if (txt.text.length < _currentTextBlock.length){
				txt.text = _currentTextBlock.substr(0, txt.text.length+1);
			}
			else{
				removeEventListener(Event.ENTER_FRAME, updateText);
				fillText();
			}
		}
		
		private function fillText(e : Event = null) : void{
			bt_next.removeEventListener(TouchEvent.TOUCH_TAP, fillText);
			bt_next.removeEventListener(MouseEvent.MOUSE_UP, fillText);
			txt.text = _currentTextBlock;
			if (_currentTextBlockIndex < _textBlocks.length-1){
				bt_next.addEventListener(TouchEvent.TOUCH_TAP, nextTextBlock);
				bt_next.addEventListener(MouseEvent.MOUSE_UP, nextTextBlock);
			}
		}
		
		private function nextTextBlock(e : Event) : void{
			bt_next.removeEventListener(TouchEvent.TOUCH_TAP, nextTextBlock);
			bt_next.removeEventListener(MouseEvent.MOUSE_UP, nextTextBlock);
			txt.text = "";
			_currentTextBlockIndex++;
			if (_currentTextBlockIndex >= _textBlocks.length-1 && _textBlocks.length > 1){
				stage.removeChild(bt_next);
				addEndBT();
			}
			_currentTextBlock = _textBlocks[_currentTextBlockIndex][TEXT];
			characterName.gotoAndStop(_textBlocks[_currentTextBlockIndex][SPEAKER]);
			CharacterLeftMain.gotoAndStop(_textBlocks[_currentTextBlockIndex][CHAR_LEFT]);
			CharacterRightMain.gotoAndStop(_textBlocks[_currentTextBlockIndex][CHAR_RIGHT]);
			addEventListener(Event.ENTER_FRAME, updateText);
			if (_textBlocks.length > 1){
				bt_next.addEventListener(TouchEvent.TOUCH_TAP, fillText);
				bt_next.addEventListener(MouseEvent.MOUSE_UP, fillText);
			}
			
		}

	}
	
}
