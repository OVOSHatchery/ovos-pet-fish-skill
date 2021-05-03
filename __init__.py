from mycroft.skills.core import MycroftSkill, intent_handler, intent_file_handler
from mycroft.messagebus.message import Message

class PetFish(MycroftSkill):
    
    def __init__(self):
        super(PetFish, self).__init__(name="PetFish")
    
    def initialize(self):
        self.gui.register_handler("pet.fish.close.screen", self.handle_close_screen)

    @intent_file_handler("show_petfish.intent")
    def show_pet_fish_ui(self, message):
        # To try this: "show virtual pet fish"
        self.gui["pet_action"] = ""
        self.gui.show_page("Petfish.qml", override_idle=True)
        
    def handle_close_screen(self, message):
        self.gui.remove_page("Petfish.qml")
        self.gui.release()
    
    @intent_file_handler("example_action.intent")
    def run_example_action(self, message):
        # To try this: "run example swim action"
        # List of actions (strings in lowercase):
        # ["swim", "playdead", "eatfood", "eatfish", "introduce", "dance", "sleep", "awake"]
        # Usage: self.gui["pet_action"] = "swim"
        self.gui["pet_action"] = "swim"

def create_skill():
    return PetFish()
