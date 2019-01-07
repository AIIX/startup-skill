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
            self.add_event('mycroft.gui.connected', self.handle_init_screen_intent)
            self.add_event('mycroft.skills.initialized', self.handle_show_wifi_screen_intent)
            self.add_event('networkConnect.wifi', self.handle_show_wifi_pass_screen_intent)
            self.add_event('networkConnect.connecting', self.handle_show_network_connecting_screen_intents)
            self.add_event('networkConnect.connected', self.handle_show_network_connected_screen_intent)
            self.add_event('networkConnect.failed', self.handle_show_network_fail_screen_intent)
            self.add_event('networkConnect.return', self.handle_return_to_networkselection)
            
        except:
            pass
        
    @intent_file_handler('show.init.screen.intent')
    def handle_init_screen_intent(self, message):
        self.gui.clear()
        self.gui["LoaderPage"] = "Init.qml"
        self.gui.show_page("MainLoader.qml")
    
    @intent_file_handler('show.wifi.screen.intent')
    def handle_show_wifi_screen_intent(self, message):
        """ 
        Wifi Screen Test
        """
        self.gui.clear()
        self.gui["LoaderPage"] = "SelectNetwork.qml"
        self.gui.show_page("MainLoader.qml")
    
    def handle_show_wifi_pass_screen_intent(self, message):
        """ 
        Wifi Screen Test
        """
        self.gui["LoaderPage"] = "NetworkConnect.qml"
        self.gui.show_page("MainLoader.qml")
        self.gui["ConnectionName"] = message.data["ConnectionName"]
        self.gui["SecurityType"] = message.data["SecurityType"]
        self.gui["DevicePath"] = message.data["DevicePath"]
        self.gui["SpecificPath"] = message.data["SpecificPath"]
    
    @intent_file_handler('show.connecting.screen.intent')
    def handle_show_network_connecting_screen_intent(self, message):
        """
        Network Connecting State
        """
        self.gui.clear()
        self.gui["LoaderPage"] = "Connecting.qml"
        self.gui.show_page("MainLoader.qml")
    
    @intent_file_handler('show.connected.screen.intent')
    def handle_show_network_connected_screen_intent(self, message):
        """
        Network Connected State
        """
        self.gui.clear()
        self.gui["LoaderPage"] = "Success.qml"
        self.gui.show_page("MainLoader.qml")
    
    @intent_file_handler('show.failed.screen.intent')
    def handle_show_network_fail_screen_intent(self, message):
        """
        Network Failed State
        """
        self.gui.clear()
        self.gui["LoaderPage"] = "Fail.qml"
        self.gui.show_page("MainLoader.qml")
        
    @intent_file_handler('show.pairing.seq1.intent')
    def handle_show_pairing_seq1_intent(self, messaage):
        """
        Dummy Pairing Process 1 Screen
        """
        self.gui.show_page("PairingSeq1.qml")
    
    @intent_file_handler('show.pairing.seq2.intent')
    def handle_show_pairing_seq2_intent(self, messaage):
        """
        Dummy Pairing Process 2 Screen
        """
        self.gui.show_page("PairingSeq2.qml")
    
    @intent_file_handler('check.updates.intent')
    def handle_check_updates_intent(self, message):
        """
        Check For Updates
        """
        self.gui.show_page("CheckUpdate.qml")

    @intent_file_handler('update.available.intent')
    def handle_update_available_intent(self, message):
        """
        Update Available
        """
        self.gui.show_page("Updating.qml")

    @intent_file_handler('update.notavailable.intent')
    def handle_update_notavailable_intent(self, message):
        """
        Updates not available
        """
        pass
    
    def handle_process_complete_intent(self):
        self.gui.clear();
    
    def handle_return_to_networkselection(self):
        self.gui.clear();
        self.gui["LoaderPage"] = "SelectNetwork.qml"
        self.gui.show_page("MainLoader.qml")
        
    def stop(self):
        pass


def create_skill():
    return StartupSkill()

