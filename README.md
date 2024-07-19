# Exynos982X-KernelSU

This is a kernel source tree adopted from https://opensource.samsung.com/uploadList# 

with KernelSU and some minor features embedded,

configured specifically for Samsung N975F d2s, but it should work without any major changes on

any samsung device based on exynos9820/exynos9825 CPU e.g.

- SM-G970F
- SM-G973F
- SM-G975F
- SM-G977B
- SM-N970F
- SM-N975F
- SM-N976B

(If it does not, please reach out to me via github issue, maybe i will be able to help)

## Table of contents

- [Build](#Build)
- [Install](#Install)
- [Changes](#Changes)

## Build

How to build?

Everything is pre-configured so you just need to run the build script 
`./build_kernel.sh`

It will build the current configuration from .config

You can change the configuration as much as you want, but when using menuconfig, 

make sure you do not overwrite the .config with another configuration or accidentally make .config.old

other automatically generated config files are the following:

- arch/arm64/configs/exynos9820-d2s_defconfig
- include/config/auto.conf
- include/generated/autoconf.h (C symbols definition)

## Install

First of all, you need to have a fully unlocked Bootloader

Cracked VBMeta or Dm-Verity could also help in preventing unexpected fails

**Disclaimer**

I am not responsible for any possible damage that may occur while flashing or using custom ROM


Well, choosing the install method is really up to you.

As far as i know, devices that use Exynos9820/Exynos9825 have a separate dtb partition.

We are going to modify only the boot partition so leave the rest of the partitions as they are.

To flash the boot partition, we will need the non-compressed "Image" from arch/arm64/boot/ 

and either make a installable zip from it (possibly using AnyKernel3 wrappers) that will be later

installed via TWRP or adb sideload (I do not recommend this approach) or make a flashable boot.img

The easiest way to craft a boot.img (does not require file signing, but may require cracked VB-Meta)

is to unpack the stock boot.img from AP using the `unpackbootimg` command, to get the following files:
```
boot.img-base      boot.img-header_version  boot.img-os_version      boot.img-second_offset
boot.img-board     boot.img-kernel          boot.img-pagesize        boot.img-tags_offset
boot.img-cmdline   boot.img-kernel_offset   boot.img-ramdisk         
boot.img-hashtype  boot.img-os_patch_level  boot.img-ramdisk_offset
```

replace boot.img-kernel with the bootable "Image" and pack everything using `mkbootimg`

boot.img crafted like this can be later flashed using `odin` / `odin4` / `heimdall`

## Changes

### KernelSU:

Unfortunately, in order to make KernelSU working, i had to disable some of the standard samsung security features,

this is a common practice, and I may try to restore some of the disabled features in the upcoming updates

The following configurations were disabled from config:

- CONFIG_UH (Samsung micro-hypervisor)
- CONFIG_UH_LKMAUTH
- CONFIG_UH_LKM_BLOCK

- CONFIG_RKP (Samsung Runtime Kernel Protection)
- CONFIG_RKP_CFP (Samsung RKP: Code Flow Protection)

- CONFIG_KPROBES (KProbes did not work for me, used manual integration instead)

Added:

- CONFIG_KSU (KernelSU manual integration)
