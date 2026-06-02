#!/usr/bin/env python3
"""Thin entry-point wrapper — implementation in ``bev.renderer`` and ``bev.tier2_renderer``.

BEV generation uses Tier2BevRenderer (xosc_gen MapPlotter style).
XodrParser and BevSnapshot are re-exported for backward compatibility.
"""
from bev.renderer import XodrParser, BevSnapshot, LaneLine, main  # noqa: F401

if __name__ == "__main__":
    main()
