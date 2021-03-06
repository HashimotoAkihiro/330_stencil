#############################################################################
# The 2nd ARC/CPSY/RECONF High-Performance Computer System Design Contest   #
# From MieruEMB System V1.0  2011-10-01                Arch Lab. TOKYO TECH #
#############################################################################

#TARGET  = stencil
#TARGET  = stencil_using_SIMD
TARGET  = stencil_using_LCache
DATA	= 330stencil
OBJS    = startup.o main.o
IMGSIZE = 256

ifndef	DATASIZE
DATASIZE = 8
#DATASIZE = 1
endif
ifndef	ITER
ITER = 500
#ITER = 1
endif
ifndef	RANDSEED
RANDSEED = 8
endif

# ifndef	DATASIZE
# DATASIZE = 300
# endif
# ifndef	RANDSEED
# RANDSEED = 3
# endif
# data:
# 	gcc -Wall data.c -o data_gen
# 	./data_gen $(DATASIZE) $(RANDSEED)

##
#CMDPREF = /home/share/cad/mipsel-contest/usr/bin/
#
#MIPSCC  = $(CMDPREF)mipsel-linux-gcc
#MIPSAS  = $(CMDPREF)mipsel-linux-as
#MIPSLD  = $(CMDPREF)mipsel-linux-ld
#OBJDUMP = $(CMDPREF)mipsel-linux-objdump
#MEMGEN  = $(CMDPREF)memgen
#SIMPROG = $(CMDPREF)SimMips
##

CMDPREF = /opt/mips-tools/bin/
MIPSCC  = $(CMDPREF)mipsel-elf-gcc
MIPSAS  = $(CMDPREF)mipsel-elf-as
MIPSLD  = $(CMDPREF)mipsel-elf-ld
OBJDUMP = $(CMDPREF)mipsel-elf-objdump
OBJCOPY = $(CMDPREF)mipsel-elf-objcopy
MEMGEN  = $(CMDPREF)memgen
SIMPROG = $(CMDPREF)SimMips


ifndef TARGET_ARCH
TARGET_ARCH = __XILINX__
endif

AFLAGS  = -march=x5900
#CFLAGS  = -D$(TARGET_ARCH) -Wall -O2 --save-temps
CFLAGS  = -D$(TARGET_ARCH) $(GEM5FLAG) -Wall -O2 --save-temps -march=x5900 -msoft-float
LFLAGS  =
BFLAGS = -Ibinary -Bmips -Oelf32-littlemips

.SUFFIXES:
.SUFFIXES: .o .c .S
######################################################################
#all:	fpga data
#	cat $(TARGET).bin $(TARGET).dat > $(TARGET)512.bin
##	cp $(TARGET)512.bin ../../bin

all:
	@echo please type \'make gem5\' or \'make fpga\'

gem5:
	$(MAKE) $(TARGET) GEM5FLAG=-DGEM5_MIPS

fpga:
	$(MAKE) clean
	cp startup$(TARGET_ARCH).S startup.S
	$(MAKE) $(TARGET)
	$(MAKE) image

data:
	gcc -Wall data.c -o data_gen
	./data_gen $(DATASIZE) $(ITER) $(RANDSEED)
	$(OBJCOPY) $(BFLAGS) $(DATA).dat $(DATA).o
#	dd if=/dev/zero of=$(TARGET).dat bs=1 count=262144

$(TARGET): $(OBJS)
	$(MIPSLD) $(LFLAGS) -T stdld.script $(OBJS) $(DATA).o -o $(TARGET)
	$(OBJDUMP) -d -M reg-names=numeric $(TARGET) > $(TARGET).asm

.c.o:
	$(MIPSCC) $(CFLAGS) -c $(@D)/$(<F) -o $(@D)/$(@F)

.c.S:
	$(MIPSCC) $(CFLAGS) -S $(@D)/$(<F) -o $(@D)/$(@F)

.S.o:
	$(MIPSCC) $(AFLAGG) -c $(@D)/$(<F) -o $(@D)/$(@F)

image:
	$(MEMGEN) -b $(TARGET) $(IMGSIZE) > $(TARGET).bin

dump:
	$(OBJDUMP) -D $(TARGET)

test:	$(TARGET)
	cp $(TARGET).dat data.bin
	$(SIMPROG) -M sim.m $(TARGET)

read:
	readelf -a $(TARGET)

clean:
	rm -f *.o *.i *.s *~ log.txt $(TARGET) $(TARGET).asm *.bin a.out
	rm -f $(TARGET).dat data_gen
######################################################################
