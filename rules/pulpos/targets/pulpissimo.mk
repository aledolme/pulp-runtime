ifdef USE_IBEX
PULP_LDFLAGS +=
PULP_CFLAGS += -D__ibex__ -U__riscv__ -UARCHI_CORE_HAS_PULPV2 -DRV_ISA_RV32
PULP_ARCH_CFLAGS ?= -march=rv32imc
PULP_ARCH_LDFLAGS ?= -march=rv32imc
PULP_ARCH_OBJDFLAGS ?= -Mmarch=rv32imc
else ifdef USE_CV32E40P
PULP_LDFLAGS +=
PULP_CFLAGS += -D__cv32e40p__ -U__riscv__ -UARCHI_CORE_HAS_PULPV2
ifdef CONFIG_USE_ZFINX
PULP_ARCH_CFLAGS ?=  -march=rv32imc_zfinx_xcorev -mnohwloop
PULP_ARCH_LDFLAGS ?=  -march=rv32imc_zfinx_xcorev -mnohwloop
else
PULP_ARCH_CFLAGS ?=  -march=rv32imc -mnohwloop
PULP_ARCH_LDFLAGS ?=  -march=rv32ic -mnohwloop
endif

PULP_ARCH_OBJDFLAGS ?=
else
PULP_LDFLAGS      += 
#PULP_CFLAGS       +=  -D__riscv__
PULP_CFLAGS += -D__cv32e40p__ -U__riscv__ -UARCHI_CORE_HAS_PULPV2
#PULP_ARCH_CFLAGS ?=  -march=rv32imcxgap9
#PULP_ARCH_LDFLAGS ?=  -march=rv32imcxgap9
PULP_ARCH_CFLAGS ?=  -march=rv32imc -mnohwloop
PULP_ARCH_LDFLAGS ?=  -march=rv32ic -mnohwloop
#PULP_ARCH_OBJDFLAGS ?= -Mmarch=rv32imcxgap9
PULP_ARCH_OBJDFLAGS ?=
endif

PULP_CFLAGS    += -fdata-sections -ffunction-sections -include chips/pulpissimo/config.h -I$(PULPRT_HOME)/include/chips/pulpissimo
PULP_OMP_CFLAGS    += -fopenmp -mnativeomp
PULP_LDFLAGS += -nostartfiles -nostdlib -Wl,--gc-sections -L$(PULPRT_HOME)/kernel -Tchips/pulpissimo/link.ld -lgcc

PULP_CC = riscv32-unknown-elf-gcc
PULP_AR ?= riscv32-unknown-elf-ar
PULP_LD ?= riscv32-unknown-elf-gcc
PULP_OBJDUMP ?= riscv32-unknown-elf-objdump

fc/archi=riscv
pe/archi=riscv
pulp_chip=pulp
pulp_chip_family=pulp
fc_itc/version=1
udma/cpi/version=1
udma/i2c/version=2
soc/fll/version=1
udma/i2s/version=2
udma/uart/version=1
event_unit/version=3
perf_counters=True
fll/version=1
padframe/version=1
udma/spim/version=3
gpio/version=3
udma/archi=3
udma/version=3
soc_eu/version=2


# FLL
PULP_SRCS     += kernel/fll-v$(fll/version).c
PULP_SRCS     += kernel/freq-domains.c
PULP_SRCS     += kernel/chips/pulpissimo/soc.c

#DRIVERS
#KECCAK_IP
PULP_SRCS     += drivers/keccak_driver.c
#NTT_INTT_PWM_IP
PULP_SRCS     += drivers/ntt_intt_pwm_driver.c
PULP_SRCS     += drivers/intt_driver.c
PULP_SRCS     += drivers/pwm_driver.c

#kyber_ip
PULP_SRCS     += kernel/kyber1024/cbd.c
PULP_SRCS     += kernel/kyber1024/fips202.c
PULP_SRCS     += kernel/kyber1024/indcpa.c
PULP_SRCS     += kernel/kyber1024/kem.c
PULP_SRCS     += kernel/kyber1024/ntt.c
PULP_SRCS     += kernel/kyber1024/poly.c
PULP_SRCS     += kernel/kyber1024/polyvec.c
PULP_SRCS     += kernel/kyber1024/randombytes.c
PULP_SRCS     += kernel/kyber1024/reduce.c
PULP_SRCS     += kernel/kyber1024/symmetric-shake.c
PULP_SRCS     += kernel/kyber1024/verify.c

include $(PULPRT_HOME)/rules/pulpos/configs/default.mk

ifeq '$(platform)' 'fpga'
CONFIG_IO_UART=1
endif

include $(PULPRT_HOME)/rules/pulpos/default_rules.mk
