OUTPUT := pong.swf

ifdef DEBUG
DEBUG_FLAG := true
else
DEBUG_FLAG := false
endif

LIBS=-compiler.include-libraries lib/SVGRenderer.swc

all:
	fcsh-wrap -optimize=true -output $(OUTPUT) -static-link-runtime-shared-libraries=true -compatibility-version=3.0.0 -frames.frame mainframe MainMenu -compiler.warn-no-type-decl=false -compiler.debug=$(DEBUG_FLAG) Main.as  $(LIBS)

clean:
	rm -f *~ $(OUTPUT)

.PHONY: all clean


