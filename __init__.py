import re
import sys
from os.path import dirname, join
from adapt.intent import IntentBuilder
from mycroft import MycroftSkill, intent_handler, intent_file_handler
from mycroft.messagebus.message import Message 

class StartupSkill(MycroftSkill):
    """ 
    Startup Skill
    """
    def initialize(self):
        try:
            self.add_event('networkConnect.wifi', self.handle_show_wifi_pass_screen_intent)

        except:
            pass
        
    @intent_file_handler('show.wifi.screen.intent')
    def handle_show_wifi_screen_intent(self, message):
        """ 
        Wifi Screen Test
        """
        self.gui.show_page("WirelessMain.qml")
        
    def handle_show_wifi_pass_screen_intent(self, message):
        """ 
        Wifi Screen Test
        """
        self.gui["ConnectionName"] = message.data["ConnectionName"]
        self.gui["SecurityType"] = message.data["SecurityType"]
        #self.gui["ConnectionPath"] = message.data["ConnectionPath"]
        self.gui["DevicePath"] = message.data["DevicePath"]
        self.gui["SpecificPath"] = message.data["SpecificPath"]
        self.gui.show_page("WirelessConnect.qml")
        
    def stop(self):
        pass


def create_skill():
    return StartupSkill()

