package  {
	
	public class SaveGame {
			var saveDataObject : SharedObject;
			
		public function SaveGame(timeline : MovieClip, p : String) {
			saveDataObject = SharedObject.getLocal("test");
			saveDataObject.data.player = p;
			saveDataObject.data.MainTimeline = timeline;
		}
		
		public function save(frame : int){
			saveDataObject.data.lastFrame = frame;
			saveDataObject.flush;
			
		}

	}
	
}
