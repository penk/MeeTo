#!/bin/sh

dbus-send --type=method_call --print-reply --dest=org.xpud.vkb / local.VkbServer.toggle
