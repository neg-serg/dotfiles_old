#!/usr/bin/env python
# Requires dbus-python and dmenu

import dbus
import re

from os import path as Path


DBUS_PROPS_INTERFACE = 'org.freedesktop.DBus.Properties'
UDISKS_INTERFACE = 'org.freedesktop.UDisks'
UDISKS_DEVICE_INTERFACE = 'org.freedesktop.UDisks.Device'

UDISKS_OBJECT = 'org.freedesktop.UDisks'
UDISKS_OBJECT_PATH = '/org/freedesktop/UDisks'


class Udisks:
    def __init__(self):
        self.bus = dbus.SystemBus()
        self.ud_manager_obj = self.bus.get_object(UDISKS_OBJECT, UDISKS_OBJECT_PATH)
        self.ud_manager = dbus.Interface(self.ud_manager_obj, UDISKS_OBJECT)

        #device_obj = self.bus.get_object(UDISKS_OBJECT, dev)
        #self.device_props = dbus.Interface(self.device_obj, dbus.PROPERTIES_IFACE)
        self.Properties = self._get_all_properties()

    def get_udisk_devs(self):
        udisks = self.bus.get_object(UDISKS_OBJECT, UDISKS_OBJECT_PATH)
        return udisks.EnumerateDevices(dbus_interface=UDISKS_INTERFACE)


    def _get_all_properties(self):
        'Retunt Dictionay of dev with props'
        devlist = self.get_udisk_devs()

        d = dbus.Dictionary()
        for i in devlist:
            dev_obj = self.bus.get_object(UDISKS_OBJECT, i)
            dev = dbus.Interface(dev_obj, DBUS_PROPS_INTERFACE)
            d[i] = dev.GetAll('')
        return d

    # --- PARAMETERS ---
    def _get_property(self, dev, property):
        return self.Properties[dev].get(property, None) if dev in list(self.Properties.keys()) else None

    def is_mounted(self, device):
        return bool(self._get_property(device, 'DeviceIsMounted'))

    def mount_paths(self, device):
        raw_paths = self._get_property(device, 'DeviceMountPaths')
        return [Path.normpath(path) for path in raw_paths]

    def is_filesystem(self, device):
        return bool(self._get_property(device, 'IdUsage') == 'filesystem')

    def has_media(self, device):
        return bool(self._get_property(device, 'DeviceIsMediaAvailable'))

    def id_type(self, device):
        return str(bool(self._get_property(device, 'IdType')))

    def devlabel(self, device):
        return str(self._get_property(device, 'IdLabel'))

    def devname(self, device):
        return str(self._get_property(device, 'DeviceFile'))

    def deviface(self, device):
        return str(self._get_property(device, 'DriveConnectionInterface'))

    def is_systeminternal(self, device):
        return bool(self._get_property(device, 'DeviceIsSystemInternal'))

    def is_handleable(self, device):
        """Should this device be handled by udisks?

        Currently this just means that the device is removable and holds a
        filesystem."""

        if self.is_filesystem(device) and not self.is_systeminternal(device):
            return True
        else:
            return False
    # --- End PARAMETERS ---

    #--- ACTIONS ---
    def mount(self, device, options):
        if not self.is_mounted(device) and self.is_handleable(device):
            filesystem = self._get_property(device, 'IdType')
            dev_obj = self.bus.get_object(UDISKS_OBJECT, device)
            dev = dbus.Interface(dev_obj, DBUS_PROPS_INTERFACE)
            try:
                dev.FilesystemMount(filesystem, options,
                        dbus_interface=UDISKS_DEVICE_INTERFACE)
            except dbus.DBusException as e:
                return (1, e)

            return (0, '')
        else:
            return (1, 'Device %s is already mount or not handleable' % self.devname(device))


    def unmount(self, device):
        if self.is_mounted(device) and self.is_handleable(device):
            dev_obj = self.bus.get_object(UDISKS_OBJECT, device)
            dev = dbus.Interface(dev_obj, DBUS_PROPS_INTERFACE)
            try:
                dev.FilesystemUnmount([], dbus_interface=UDISKS_DEVICE_INTERFACE)
            except dbus.DBusException as e:
                return (1, e)

            return (0, '')
        else:
            return (1, 'Device %s is not mounted or not handleable' % self.devname(device))

    def get_mountable_devices(self):
        devlist = self.get_udisk_devs()

        d = []
        for i in devlist:
            dev_obj = self.bus.get_object(UDISKS_OBJECT, i)
            dev = dbus.Interface(dev_obj, DBUS_PROPS_INTERFACE)
            if not self.is_mounted(i) and self.is_handleable(i) and self.has_media(i):
                d.append(str(self.deviface(i)).upper() + ': ' +
                    str(self.devlabel(i)) + ' (' + str(self.devname(i)) + ')')
        return d

    def get_unmountable_devices(self):
        devlist = self.get_udisk_devs()

        d = []
        for i in devlist:
            dev_obj = self.bus.get_object(UDISKS_OBJECT, i)
            dev = dbus.Interface(dev_obj, DBUS_PROPS_INTERFACE)
            if self.is_mounted(i) and self.is_handleable(i):
                mountpoins = str(', '.join(self.mount_paths(i)))
                d.append(mountpoins + ' (' + str(self.devname(i)) + ')')
        return d

    def nametodev(self, name):
        return str(self.ud_manager.FindDeviceByDeviceFile(name))
    #--- End ACTIONS ---


def _run_Cmd(cmd, string):
    from subprocess import Popen
    from subprocess import PIPE

    returncode = 1

    try:
        p = Popen(cmd, stdout=PIPE, stdin=PIPE, stderr=PIPE, close_fds=True)

        (out, err) = p.communicate(input=bytes(string, 'utf-8'))
        (out, err) = (str(i) for i in (out, err))
        returncode = p.returncode
    except OSError as e:
        (out, err) = ('', 'Error while exec: %s' % str(cmd))

    return (returncode, out, err)

def Mount(args):

    U = Udisks()
    Devs = U.get_mountable_devices()

    if Devs:
        string = '\n'.join(Devs)
        mydev = _run_Cmd(args.dmenu, string)
        if mydev[0] is 0:
            devname = re.search(r"\([^}]+\)", mydev[1]).group().strip(')(')
            dev = U.nametodev(devname)
            if dev and dev in list(U.Properties.keys()):
                (res, err) = U.mount(dev, [])
            else:
                raise IOError('Error mounting. Unknown device')
        else:
            print('Error runing dmenu')

def Unmount(args):

    U = Udisks()
    Devs = U.get_unmountable_devices()

    if Devs:
        string = '\n'.join(Devs)
        mydev = _run_Cmd(args.dmenu, string)
        if mydev[0] is 0:
            devname = re.search(r"\([^}]+\)", mydev[1]).group().strip(')(')
            dev = U.nametodev(devname)
            if dev and dev in list(U.Properties.keys()):
                (res, err) = U.unmount(dev)
            else:
                raise IOError('Error unmounting. Unknown device')
        else:
            print('Error runing dmenu')

def parse_options():
    import argparse
    import sys

    parser = argparse.ArgumentParser()
    actions = parser.add_mutually_exclusive_group(required=True)
    # The action this script should perform (mounting or unmounting) is
    # stored in the action attribute of the arguments namespace
    # TODO: Cannot mount like this; need to get targets in a certain
    # format
    actions.add_argument('-m', '--mount', action='store_const',
            const=Mount, dest='action',
            help='Mounts the specified devices')
    actions.add_argument('-u', '--unmount', action='store_const',
            const=Unmount, dest='action',
            help='Unmounts the specified mountpoints')

    # We have to create the arguments namespace prior to parsing, in
    # order to put the dmenu argument list into it
    args = argparse.Namespace()
    arglist = []
    try:
        idx = sys.argv.index('--')
        arglist = sys.argv[:idx]
        dmenu_arglist = sys.argv[idx+1:]
        args.dmenu = dmenu_arglist
    except ValueError:
        arglist = sys.argv

    # Parse the above switches only, the rest of the command-line
    # arguments is left untouched and used as arguments for the
    # mount/unmount actions
    _, args.targets = parser.parse_known_args(args=arglist, namespace=args)
    return args


if __name__ == '__main__':
    args = parse_options()
    args.action(args)
