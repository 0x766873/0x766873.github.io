---
title: WSL2 Kernel Compilation with Custom Drivers
date: 2025-05-06
draft: "true"
tags:
  - tool
  - wsl2
  - driver
---

Windows Subsystem for Linux 2 (WSL2) offers a powerful way to run a full Linux kernel directly on Windows. While WSL2 works well out of the box, there are times when custom kernel modifications are needed—especially for enabling support for specific hardware drivers. In this post, we'll walk through how to fork and modify the WSL2 Linux Kernel to support the RTL8812AU driver, commonly used for the Alfa AWUS036ACH Wi-Fi adapter.

Though this guide focuses on the RTL8812AU driver, the steps are broadly applicable to any driver compatible with the Linux kernel version used in WSL2.

## Why Modify the WSL2 Kernel?

By default, the kernel provided with WSL2 doesn't include certain third-party drivers, particularly for Wi-Fi adapters like the Alfa AWUS036ACH. Installing such drivers requires rebuilding the kernel with the necessary modules included. Microsoft makes this possible by offering the WSL2 kernel as an open-source project on GitHub.

## Step-by-Step Guide

### Fork the WSL2 Linux Kernel

Start by forking the official WSL2 Linux Kernel repository:

📁 [WSL2 Linux Kernel on GitHub](https://github.com/microsoft/WSL2-Linux-Kernel)

### Clone Your Forked Repository

Clone the forked repository to your local development environment:

```bash
git clone https://github.com/USERNAME/WSL2-Linux-Kernel.git
cd WSL2-Linux-Kernel
```

### Add the RTL8812AU Driver

Download or clone the RTL8812AU driver source. Make sure it includes a `Makefile` and `Kconfig` file.

A popular repository for the RTL8812AU driver is:

📁 [RTL8812AU on GitHub](https://github.com/aircrack-ng/rtl8812au) (now deprecated)
📁 [rtw88 on GitHub](https://github.com/lwfinger/rtw88)

Place the driver directory in the appropriate location within the kernel source tree, usually under `drivers/net/wireless/`.

### Integrate the Driver in the Kernel Configuration

To ensure the kernel builds the new module:

- Add an entry for the RTL8812AU driver in the parent `Kconfig` file under `drivers/net/wireless/`.
- Optionally add a line in the corresponding `Makefile` to compile the driver.

Example in `drivers/net/wireless/Kconfig`:

```
source "drivers/net/wireless/rtl8812au/Kconfig"
```

Example in `drivers/net/wireless/Makefile`:

```make
obj-$(CONFIG_RTL8812AU) += rtl8812au/
```

Ensure `CONFIG_RTL8812AU` is enabled in your `.config` during kernel configuration.

### Build and Install the Custom Kernel

After modifying the kernel source:

```bash
make KCONFIG_CONFIG=.config -j$(nproc)
```

Once the kernel is built, follow Microsoft’s instructions for using a custom kernel with WSL2 by setting the `kernel` path in your `.wslconfig` file.

More info: [Microsoft WSL2 Kernel Documentation](https://github.com/microsoft/WSL2-Linux-Kernel)

## Additional Resources

- 📚 [Microsoft’s WSL2 Linux Kernel](https://github.com/microsoft/WSL2-Linux-Kernel)
- 🔧 [EDLLT WSL2 Kernel Fork](https://github.com/EDLLT/WSL2-Linux-Kernel)
- 🔍 [My Kernel Customization](https://github.com/0x766873/WSL2-Linux-Kernel)
