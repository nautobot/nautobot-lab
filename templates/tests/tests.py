import pytest


def test_dcim_devices(nautobot):
    devices = nautobot.dcim.devices
    assert len(devices.all()) > 1
