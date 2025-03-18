from __future__ import print_function, division


class PreventableCheckerBase:
    def reset(self):
        pass

    def is_preventable(self):
        return True
