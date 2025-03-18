#!/usr/bin/env python
import numpy as np

from accident_base import AccidentBase

class NLIAOppositeAccident(AccidentBase):
    def __init__(self):
        AccidentBase.__init__(self, "NLIAOppositeAccident")

    def _match_result(self, pf):
        