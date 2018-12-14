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
            self.add_event('networkConnect.connecting', self.handle_show_network_connecting_screen_intents)
            self.add_event('networkConnect.connected', self.handle_show_network_connected_screen_intent)
            self.add_event('networkConnect.failed', self.handle_show_network_fail_screen_intent)
            
        except:
            pass
        
    @intent_file_handler('show.thinking.screen.intent')
    def handle_show_thinking_screen_intent(self, message):
        self.gui.show_page("Thinking.qml")
    
    @intent_file_handler('show.wifi.screen.intent')
    def handle_show_wifi_screen_intent(self, message):
        """ 
        Wifi Screen Test
        """
        self.gui.show_page("NetworkMain.qml")
    
    def handle_show_wifi_pass_screen_intent(self, message):
        """ 
        Wifi Screen Test
        """
        self.gui["ConnectionName"] = message.data["ConnectionName"]
        self.gui["SecurityType"] = message.data["SecurityType"]
        self.gui["DevicePath"] = message.data["DevicePath"]
        self.gui["SpecificPath"] = message.data["SpecificPath"]
        self.gui.show_page("NetworkConnect.qml")
    
    @intent_file_handler('show.connecting.screen.intent')
    def handle_show_network_connecting_screen_intent(self, message):
        """
        Network Connecting State
        """
        self.gui.show_page("Connecting.qml")
    
    @intent_file_handler('show.connected.screen.intent')
    def handle_show_network_connected_screen_intent(self, message):
        """
        Network Connected State
        """
        self.gui.show_page("Success.qml")
    
    @intent_file_handler('show.failed.screen.intent')
    def handle_show_network_fail_screen_intent(self, message):
        """
        Network Failed State
        """
        self.gui.show_page("Fail.qml")
    
    def stop(self):
        pass


def create_skill():
    return StartupSkill()

