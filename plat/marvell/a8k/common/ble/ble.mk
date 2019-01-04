# Copyright (C) 2018 Marvell International Ltd.
#
# SPDX-License-Identifier:     BSD-3-Clause
# https://spdx.org/licenses

MV_DDR_PATH		?=	drivers/marvell/mv_ddr

MV_DDR_LIB		= 	$(CURDIR)/$(BUILD_PLAT)/ble/mv_ddr_lib.a
LIBC_LIB		=	$(CURDIR)/$(BUILD_PLAT)/lib/libc.a
BLE_LIBS		= 	$(MV_DDR_LIB) $(LIBC_LIB)
PLAT_MARVELL		=	plat/marvell

BLE_SOURCES		+= 	$(BLE_PATH)/ble_main.c				\
				$(BLE_PATH)/ble_mem.S				\
				drivers/delay_timer/delay_timer.c		\
				$(PLAT_MARVELL)/common/aarch64/marvell_helpers.S \
				$(PLAT_MARVELL)/common/plat_delay_timer.c	\
				$(PLAT_MARVELL)/common/marvell_console.c

PLAT_INCLUDES		+= 	-I$(MV_DDR_PATH) \
				-I$(CURDIR)/include/ \
				-I$(CURDIR)/include/lib \
				-I$(CURDIR)/include/lib/libc \
				-I$(CURDIR)/include/lib/libc/aarch64 \
				-I$(CURDIR)/drivers/marvell

BLE_LINKERFILE		:=	$(BLE_PATH)/ble.ld.S

FORCE:

$(MV_DDR_LIB): FORCE
	@+make -C $(MV_DDR_PATH) --no-print-directory PLAT_INCLUDES="$(PLAT_INCLUDES)" PLATFORM=$(PLAT) ARCH=AARCH64 OBJ_DIR=$(CURDIR)/$(BUILD_PLAT)/ble
