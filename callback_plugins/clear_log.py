import os

TMP_PATH = '/tmp/ansible.log'

class CallbackModule(object):
    """
    clears the local ansible.log on before the start of a play
    """

    def playbook_on_start(self):
        if os.path.exists(TMP_PATH):
          log_file = os.path.join(os.getcwd(), '/tmp/ansible.log')
          open(log_file, 'w').close()
