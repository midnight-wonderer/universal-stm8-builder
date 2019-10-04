SRC_DIR ?= ./src
VENDOR_DIR ?= ./vendor
BIN_DIR ?= ./bin
ENTRY_SOURCE_FILE ?= $(shell find $(SRC_DIR) -maxdepth 1 -name "main.c")
APP_SOURCE_FILES ?= $(filter-out $(ENTRY_SOURCE_FILE), $(shell find $(SRC_DIR) -name "*.c"))
INCLUDE_PATHS ?= $(shell find . -type f -name '*.h' -exec dirname {} \; | sort | uniq)
LIB_SOURCE_FILES ?= $(shell find $(VENDOR_DIR) -type f -name '*.c' -exec dirname {} \; | sort | uniq)

ENTRY_OBJECT=$(subst /./,/,$(addprefix $(BIN_DIR)/,$(ENTRY_SOURCE_FILE:.c=.rel)))
APP_OBJECTS=$(subst /./,/,$(addprefix $(BIN_DIR)/,$(APP_SOURCE_FILES:.c=.rel)))
LIB_OBJECTS=$(subst /./,/,$(addprefix $(BIN_DIR)/,$(LIB_SOURCE_FILES:.c=.rel)))

OUTPUT_HEX ?= $(BIN_DIR)/program.hex

CFLAGS = -mstm8 --std-c11 --nolospre $(addprefix -I,$(INCLUDE_PATHS)) $(CDEFS)
LDFLAGS = -lstm8 --out-fmt-ihx

$(OUTPUT_HEX): $(ENTRY_OBJECT) $(BIN_DIR)/vendor.lib $(BIN_DIR)/app.lib
	$(CC) -o $@ $(LDFLAGS) $^

$(BIN_DIR)/%.rel: %.c
	mkdir -p $(dir $@) &&\
	$(CC) -o $@ -c $(CFLAGS) $^

$(BIN_DIR)/vendor.lib: $(LIB_OBJECTS)
	mkdir -p $(dir $@) &&\
	[[ ! -z "$^" ]] &&\
	$(AR) -rc $@ $^ ||\
	touch $@

$(BIN_DIR)/app.lib: $(APP_OBJECTS)
	mkdir -p $(dir $@) &&\
	[[ ! -z "$^" ]] &&\
	$(AR) -rc $@ $^ ||\
	touch $@
