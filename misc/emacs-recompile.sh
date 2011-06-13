#! /bin/sh

INITFILE=$HOME/.emacs.d/misc/compile-init.el
COMPILE_PATH=$HOME/.emacs.d/conf
ELISP_FILES=$(find -L $COMPILE_PATH -iname "*.el")
COMPILED_FILES=$(find -L $COMPILE_PATH -iname "*.elc")

EMACS_ARGS="
--quick
--load $INITFILE
--batch
--funcall batch-byte-compile $ELISP_FILES
"

rm -f $COMPILED_FILES

nice -n 5 ionice -c 3 emacs $EMACS_ARGS 2>&1 | grep -E "^Debugger entered|Error"

NUMBER_OF_ELISP_FILES=$(find -L $COMPILE_PATH -iname "*.el" | wc -l)
NUMBER_OF_COMPILED_FILES=$(find -L $COMPILE_PATH -iname "*.elc" | wc -l)

echo "Compiled" $NUMBER_OF_COMPILED_FILES/$NUMBER_OF_ELISP_FILES "files"
